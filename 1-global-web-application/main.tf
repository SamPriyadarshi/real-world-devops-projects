resource "google_compute_global_address" "default" {
  name    = "external-ip"
  project = var.project_id
}

resource "google_compute_network" "default" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = true
}

resource "google_compute_router" "default" {
  name    = "${var.app_name}-cloud-router"
  project = var.project_id
  region  = var.region
  network = google_compute_network.default.id
}

resource "google_compute_router_nat" "default" {
  name                               = "${var.app_name}-nat-gateway"
  project                            = var.project_id
  region                             = var.region
  router                             = google_compute_router.default.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
}

resource "google_compute_router" "default_eu" {
  name    = "${var.app_name}-cloud-router-eu"
  project = var.project_id
  region  = var.secondary_region
  network = google_compute_network.default.id
}

resource "google_compute_router_nat" "default_eu" {
  name                               = "${var.app_name}-nat-gateway-eu"
  project                            = var.project_id
  region                             = var.secondary_region
  router                             = google_compute_router.default_eu.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
}

module "firewall" {
  source                 = "./modules/firewall"
  project_id             = var.project_id
  network                = google_compute_network.default.name
  http_firewall_name     = "${var.app_name}-firewall-http"
  ssh_firewall_name      = "${var.app_name}-firewall-ssh"
  internal_firewall_name = "${var.app_name}-firewall-internal"
  target_tags            = ["${var.app_name}-http-server"]
  ssh_source_ranges      = var.ssh_source_ranges
}

module "instance_template" {
  source         = "./modules/instance_template"
  project_id     = var.project_id
  name_prefix    = "${var.app_name}-"
  network        = google_compute_network.default.id
  source_image   = var.source_image
  machine_type   = var.machine_type
  instance_tags  = ["${var.app_name}-http-server"]
  startup_script = templatefile("startup_script.tpl", { bucket_name = var.bucket_name })
}

module "mig" {
  source                         = "./modules/mig"
  project_id                     = var.project_id
  mig_name                       = "${var.app_name}-mig"
  base_instance_name             = var.app_name
  region                         = var.region
  instance_template_self_link    = module.instance_template.instance_template_id
  health_check_self_link         = module.load_balancer.health_check_id
  autoscaler_name                = "${var.app_name}-autoscaler"
  min_replicas                   = var.min_replicas
  max_replicas                   = var.max_replicas
  cpu_target_utilization         = var.cpu_target_utilization
  auto_healing_initial_delay_sec = var.auto_healing_initial_delay_sec
}

module "mig_eu" {
  source                         = "./modules/mig"
  project_id                     = var.project_id
  mig_name                       = "${var.app_name}-mig-eu"
  base_instance_name             = "${var.app_name}-eu"
  region                         = var.secondary_region
  instance_template_self_link    = module.instance_template.instance_template_id
  health_check_self_link         = module.load_balancer.health_check_id
  autoscaler_name                = "${var.app_name}-autoscaler-eu"
  min_replicas                   = var.min_replicas
  max_replicas                   = var.max_replicas
  cpu_target_utilization         = var.cpu_target_utilization
  auto_healing_initial_delay_sec = var.auto_healing_initial_delay_sec
}

module "load_balancer" {
  source                           = "./modules/load_balancer"
  project_id                       = var.project_id
  http_health_check_name           = "${var.app_name}-http-healthcheck"
  backend_service_name             = "${var.app_name}-backend-service"
  region                           = var.region
  mig_self_link                    = module.mig.instance_group_id
  mig_eu_self_link                 = module.mig_eu.instance_group_id
  url_map_name                     = "${var.app_name}-url-map"
  https_proxy_name                 = "${var.app_name}-https-proxy"
  forwarding_rule_name             = "${var.app_name}-forwarding-rule"
  global_address_ip                = google_compute_global_address.default.address
  health_check_interval            = var.health_check_interval
  health_check_healthy_threshold   = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
  health_check_timeout             = var.health_check_timeout
  ssl_certificate_name             = "${var.app_name}-ssl-cert"
  dns_subdomain                    = var.dns_subdomain
  dns_zone_name                    = var.dns_zone_name
}

module "storage_bucket" {
  source          = "./modules/storage_bucket"
  project_id      = var.project_id
  bucket_name     = var.bucket_name
  bucket_location = var.bucket_location
  force_destroy   = var.force_destroy
  files = {
    "index.html" = "files/index.html"
    "main.css"   = "files/main.css"
  }
}

resource "google_dns_record_set" "a_record" {
  project      = var.project_id
  name         = "${var.dns_subdomain}.${var.dns_zone_name}."
  type         = "A"
  ttl          = 300
  managed_zone = var.dns_managed_zone_name

  rrdatas = [google_compute_global_address.default.address]
}

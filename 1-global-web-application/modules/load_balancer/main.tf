resource "google_compute_health_check" "http" {
  name                = var.http_health_check_name
  project             = var.project_id
  check_interval_sec  = var.health_check_interval
  healthy_threshold   = var.health_check_healthy_threshold
  unhealthy_threshold = var.health_check_unhealthy_threshold
  timeout_sec         = var.health_check_timeout
  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "default" {
  name                  = var.backend_service_name
  project               = var.project_id
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_health_check.http.id]
  session_affinity      = "NONE"

  backend {
    group           = var.mig_self_link
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 1.0
  }

  backend {
    group           = var.mig_eu_self_link
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
    capacity_scaler = 1.0
  }
}

resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  project         = var.project_id
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_https_proxy" "default" {
  name      = var.https_proxy_name
  project   = var.project_id
  url_map   = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = var.forwarding_rule_name
  project               = var.project_id
  load_balancing_scheme = "EXTERNAL"
  target                = google_compute_target_https_proxy.default.id
  port_range            = "443"
  ip_address            = var.global_address_ip
}

resource "google_compute_managed_ssl_certificate" "default" {
  project = var.project_id
  name    = var.ssl_certificate_name
  type    = "MANAGED"

  managed {
    domains = ["${var.dns_subdomain}.${var.dns_zone_name}"]
  }
}
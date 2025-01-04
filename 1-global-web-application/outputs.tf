output "instance_template_id" {
  value = module.instance_template.instance_template_id
}

output "instance_group_id" {
  value = module.mig.instance_group_id
}

output "health_check_id" {
  value = module.load_balancer.health_check_id
}

output "backend_service_id" {
  value = module.load_balancer.backend_service_id
}

output "forwarding_rule_ip_address" {
  value = google_compute_global_address.default.address
}

output "url_map_id" {
  value = module.load_balancer.url_map_id
}
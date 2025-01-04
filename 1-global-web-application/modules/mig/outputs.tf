output "mig_id" {
  value = google_compute_region_instance_group_manager.default.id
}

output "instance_group_id" {
  value = data.google_compute_region_instance_group.default.id
}
resource "google_compute_instance_template" "default" {
  name_prefix  = var.name_prefix
  machine_type = var.machine_type
  project      = var.project_id
  tags         = var.instance_tags

  lifecycle {
    create_before_destroy = true
  }

  disk {
    source_image = var.source_image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = var.network
  }

  metadata_startup_script = var.startup_script

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
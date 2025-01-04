resource "google_compute_region_instance_group_manager" "default" {
  name               = var.mig_name
  project            = var.project_id
  base_instance_name = var.base_instance_name
  region             = var.region

  named_port {
    name = "http"
    port = 80
  }

  version {
    instance_template = var.instance_template_self_link
  }

  target_size = var.target_size

  auto_healing_policies {
    initial_delay_sec = var.auto_healing_initial_delay_sec
    health_check      = var.health_check_self_link
  }

  update_policy {
    type                    = "PROACTIVE"
    minimal_action           = "REFRESH"
    max_surge_fixed        = 3
    max_unavailable_fixed  = 3
    instance_redistribution_type = "PROACTIVE"
  }
}

data "google_compute_region_instance_group" "default" {
  provider = google
  name     = google_compute_region_instance_group_manager.default.name
  project  = var.project_id
  region   = var.region

  depends_on = [
    google_compute_region_instance_group_manager.default
  ]
}

resource "google_compute_region_autoscaler" "default" {
  name    = var.autoscaler_name
  project = var.project_id
  region  = var.region
  target  = google_compute_region_instance_group_manager.default.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period

    cpu_utilization {
      predictive_method = "STANDARD_AUTOSCALING"
      target            = var.cpu_target_utilization
    }

    # Optional: Add other scaling metrics if needed (load balancing utilization, custom metrics)
  }
}

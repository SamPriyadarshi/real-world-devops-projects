resource "google_compute_firewall" "http_server" {
  name    = var.http_firewall_name
  project = var.project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.target_tags
}

resource "google_compute_firewall" "ssh" {
  name    = var.ssh_firewall_name
  project = var.project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = var.target_tags
}

resource "google_compute_firewall" "internal" {
  name    = var.internal_firewall_name
  project = var.project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_tags = var.target_tags
}

resource "google_compute_firewall" "allow_egress" {
  name        = "allow-egress"
  project     = var.project_id
  network     = var.network
  description = "Creates firewall rule targeting tagged instances to allow egress traffic"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  direction   = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
  target_tags = var.target_tags
}
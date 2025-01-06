terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.10.0"
    }
  }

    backend "gcs" {
    bucket = "real-world-devops-state" # Replace with your bucket name
    prefix = "terraform/state"
  }
}

variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "app_name" {
  description = "A name for the application (used for resource naming)"
  type        = string
  default     = "interstellar"
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "interstellar-network"
}

variable "ssh_source_ranges" {
  description = "Source IP ranges allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Be more restrictive in production
}

variable "source_image" {
  description = "Source image for the instances"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "machine_type" {
  description = "Machine type for the instances"
  type        = string
  default     = "e2-medium"
}

variable "min_replicas" {
  description = "Minimum number of instances in the MIG"
  type        = number
  default     = 2
}

variable "max_replicas" {
  description = "Maximum number of instances in the MIG"
  type        = number
  default     = 5
}

variable "cpu_target_utilization" {
  description = "Target CPU utilization for autoscaling"
  type        = number
  default     = 0.8
}

variable "bucket_name" {
  description = "Name of the GCS bucket for website files"
  type        = string
}

variable "bucket_location" {
  description = "Location of the GCS bucket"
  type        = string
  default     = "US"
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete if the bucket contains objects."
  type        = bool
  default     = false
}

variable "health_check_interval" {
  description = "Interval for the HTTP health check"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "Healthy threshold for the HTTP health check"
  type        = number
  default     = 1
}

variable "health_check_unhealthy_threshold" {
  description = "Unhealthy threshold for the HTTP health check"
  type        = number
  default     = 5
}

variable "health_check_timeout" {
  description = "Timeout for the HTTP health check"
  type        = number
  default     = 5
}

variable "auto_healing_initial_delay_sec" {
  description = "Initial delay (in seconds) for auto-healing"
  type        = number
  default     = 60
}

variable "startup_script" {
  description = "Startup script to run on instance creation"
  type        = string
  default     = null
}

variable "dns_zone_name" {
  description = "The name of the DNS zone (without trailing dot)"
  type        = string
  default     = "google-cloud-pocs.dev"
}

variable "dns_managed_zone_name" {
  description = "The name of the managed DNS zone in Cloud DNS"
  type        = string
  default     = "google-cloud-pocs-dev"
}

variable "dns_subdomain" {
  description = "Subdomain to create the certificate and A record for"
  type        = string
  default     = "interstellar"
}

variable "secondary_region" {
  description = "The secondary region for the new instance group"
  type        = string
  default     = "europe-west2"
}

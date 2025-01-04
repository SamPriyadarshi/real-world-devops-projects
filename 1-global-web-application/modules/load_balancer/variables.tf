variable "http_health_check_name" {
  description = "Name of the HTTP health check"
  type        = string
}

variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "health_check_interval" {
  description = "Interval for the HTTP health check"
  type = number
  default = 5
}

variable "health_check_healthy_threshold" {
  description = "Healthy threshold for the HTTP health check"
  type = number
  default = 1
}

variable "health_check_unhealthy_threshold" {
  description = "Unhealthy threshold for the HTTP health check"
  type = number
  default = 5
}

variable "health_check_timeout" {
  description = "Timeout for the HTTP health check"
  type = number
  default = 5
}

variable "backend_service_name" {
  description = "Name of the backend service"
  type        = string
}

variable "region" {
  description = "Region where the backend service will be created"
  type        = string
}

variable "mig_self_link" {
  description = "Self link of the MIG to attach to the backend service"
  type        = string
}

variable "url_map_name" {
  description = "Name of the URL map"
  type        = string
}

variable "https_proxy_name" {
  description = "Name of the HTTPS proxy"
  type        = string
}

variable "forwarding_rule_name" {
  description = "Name of the forwarding rule"
  type        = string
}

variable "global_address_ip" {
  description = "IP address of global static IP to use"
  type        = string
}

variable "ssl_certificate_name" {
  description = "Name of the SSL certificate"
  type        = string
}

variable "dns_subdomain" {
  description = "Subdomain to create the certificate for"
  type        = string
}

variable "dns_zone_name" {
  description = "The name of the DNS zone (without trailing dot)"
  type        = string
}

variable "http_proxy_name" {
  description = "Name of the HTTP target proxy"
  type        = string
  default     = "my-http-proxy"
}

variable "mig_eu_self_link" {
  description = "Self link of the MIG in eu-west2 region to attach to the backend service"
  type        = string
}
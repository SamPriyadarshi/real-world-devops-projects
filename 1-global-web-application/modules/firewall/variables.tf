variable "http_firewall_name" {
  description = "Name of the HTTP firewall rule"
  type        = string
}

variable "ssh_firewall_name" {
  description = "Name of the SSH firewall rule"
  type        = string
}

variable "internal_firewall_name" {
  description = "Name of the internal traffic firewall rule"
  type        = string
}

variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "network" {
  description = "Name of the network to create the firewall rules in"
  type        = string
}

variable "target_tags" {
  description = "Target tags for the firewall rules"
  type        = list(string)
}

variable "ssh_source_ranges" {
  description = "Source IP ranges allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

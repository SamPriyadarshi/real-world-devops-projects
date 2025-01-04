variable "name_prefix" {
  description = "Prefix for the instance template name"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the instances"
  type        = string
  default     = "e2-medium"
}

variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "instance_tags" {
  description = "Instance tags to apply to the template"
  type        = list(string)
  default     = []
}

variable "source_image" {
  description = "Source image for the instances"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "startup_script" {
  description = "Startup script to run on instance creation"
  type        = string
  default     = ""
}

variable "network" {
  description = "Network to deploy the instances in"
  type = string
}
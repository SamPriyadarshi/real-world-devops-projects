variable "mig_name" {
  description = "Name of the MIG"
  type        = string
}

variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "base_instance_name" {
  description = "Base name for instances in the MIG"
  type        = string
}

variable "region" {
  description = "Region where the MIG will be created"
  type        = string
}

variable "instance_template_self_link" {
  description = "Self link of the instance template"
  type        = string
}

variable "target_size" {
  description = "Initial target size of the MIG"
  type        = number
  default = 2
}

variable "auto_healing_initial_delay_sec" {
  description = "Initial delay (in seconds) for auto-healing"
  type = number
  default = 60
}

variable "health_check_self_link" {
  description = "Self link of the HTTP health check"
  type        = string
}

variable "max_surge_fixed" {
  description = "Maximum number of instances that can be created above target during an update"
  type = number
  default = 1
}

variable "max_unavailable_fixed" {
  description = "Maximum number of instances that can be unavailable during an update"
  type = number
  default = 1
}

variable "autoscaler_name" {
  description = "Name of the autoscaler"
  type        = string
}

variable "max_replicas" {
  description = "Maximum number of instances the autoscaler can create"
  type        = number
}

variable "min_replicas" {
  description = "Minimum number of instances the autoscaler can create"
  type        = number
}

variable "cooldown_period" {
  description = "Cooldown period (in seconds) between scaling actions"
  type        = number
  default     = 60
}

variable "cpu_target_utilization" {
  description = "Target CPU utilization for scaling"
  type        = number
  default     = 0.8
}

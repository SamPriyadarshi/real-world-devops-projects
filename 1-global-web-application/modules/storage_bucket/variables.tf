variable "bucket_name" {
  description = "Name of the storage bucket"
  type        = string
}

variable "project_id" {
  description = "The project ID where resources will be created"
  type        = string
}

variable "bucket_location" {
  description = "Location of the storage bucket"
  type        = string
  default     = "US"
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete if the bucket contains objects."
  type        = bool
  default     = false
}

variable "files" {
  description = "A map of files to upload to the bucket, where the key is the desired object name and the value is the local file path."
  type        = map(string)
  default     = {}
}

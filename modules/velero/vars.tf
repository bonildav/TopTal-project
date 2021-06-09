variable "bucket_name" {
  type        = string
  default     = "toptal-bucket-velero"
  description = "Name of the Velero bucket in GCP"
}

variable "cluster_name" {
  type        = string
  default     = "toptal"
  description = "Name of the GKE cluster"
}

variable "project_id" {
  type        = string
  default     = "learning-project-288414"
  description = "Name of the project in GCP"
}

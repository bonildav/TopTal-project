variable "velero_bucket_name" {
  type        = string
  default     = "toptal-bucket-velero"
  description = "Name of the Velero bucket in GCP"
}


variable "vpc_name" {
  type        = string
  default     = "vpc-network"
  description = "Name of the VPC used in GCP"
}


variable "subnetwork_name" {
  type        = string
  default     = "terraform-subnetwork"
  description = "Name of the Subnetwork used in GCP"
}

variable "region" {
  default     = "us-central1"
  type        = string
  description = "Value of the GCP region"
}


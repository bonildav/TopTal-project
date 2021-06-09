variable "zone" {
  default = "us-central1-c"
}

variable "network_name" {
  type        = string
  description = "Name of the VPC used in GCP"
}

variable "subnetwork_name" {
  type        = string
  description = "Name of the Subnetwork used in GCP"
}

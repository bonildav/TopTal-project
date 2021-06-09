variable "cluster_name" {
  type        = string
  default     = "toptal"
  description = "Name of the GKE cluster"
}

variable "node_name" {
  type        = string
  default     = "toptal-node"
  description = "Name of the GKE node"
}

variable "region" {
  default     = "us-central1"
  type        = string
  description = "Value of the GCP region"
}

variable "zone" {
  default     = "us-central1-c"
  type        = string
  description = "Value for GKE username"
}

variable "project_id" {
  type        = string
  default     = "learning-project-288414"
  description = "Name of the project in GCP"
}

variable "gke_num_nodes" {
  type        = number
  default     = 2
  description = "Number of GKE nodes"
}

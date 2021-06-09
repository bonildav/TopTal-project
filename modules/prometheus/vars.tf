variable "ns_name" {
  type        = string
  default     = "monitoring"
  description = "Namespace name for prometheus and grafana"
}

variable "chart" {
  type        = string
  default     = "kube-prometheus-stack"
  description = "Chart name"
}


variable "repository" {
  type        = string
  default     = "https://prometheus-community.github.io/helm-charts"
  description = "Repository name"
}

variable "release_name" {
  type        = string
  default     = "prometheus"
  description = "Helm release name"
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

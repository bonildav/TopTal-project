variable "ns_name" {
  type        = string
  default     = "loki"
  description = "Namespace name for prometheus and grafana"
}

variable "chart" {
  type        = string
  default     = "loki-stack"
  description = "Chart name"
}


variable "repository" {
  type        = string
  default     = "https://grafana.github.io/helm-charts"
  description = "Repository name"
}

variable "release_name" {
  type        = string
  default     = "loki"
  description = "Helm release name"
}

variable "cluster_name" {
  type        = string
  default     = "toptal"
  description = "Name of the GKE cluster"
}

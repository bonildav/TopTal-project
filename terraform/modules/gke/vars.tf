variable "cluster_name" {
  default = "toptal"
}

variable "node_name" {
  default = "toptal-node"
}


variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "network_name" {
}

variable "subnetwork_name" {
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}


variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

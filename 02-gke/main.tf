#Google Kubernetes Engine
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    bucket = "chuby-terraform-bucket"
    prefix = "network/state"
  }
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name                     = "${var.cluster_name}-gke"
  location                 = var.zone
  project                  = var.project_id
  remove_default_node_pool = true
  initial_node_count       = var.gke_num_nodes
  network                  = data.terraform_remote_state.vpc.outputs.vpc_name
  subnetwork               = data.terraform_remote_state.vpc.outputs.subnet_name
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  logging_service          = "logging.googleapis.com/kubernetes"
  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes
  project    = var.project_id

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.full_control"
    ]

    labels = {
      env = var.cluster_name
      csm = ""
    }
    preemptible  = true
    machine_type = "e2-standard-2"
    tags         = ["gke-node", "${var.cluster_name}-gke", "bank-of-anthos"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

resource "null_resource" "deploy_cluster" {
  depends_on = [google_container_node_pool.primary_nodes]
  provisioner "local-exec" {
    command = "./autodeploy.sh"
  }
}

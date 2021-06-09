
# GKE cluster
resource "google_container_cluster" "primary" {
  name                     = "${var.cluster_name}-gke"
  location                 = "${var.region}-c"
  remove_default_node_pool = true
  initial_node_count       = var.gke_num_nodes
  network                  = var.network_name
  subnetwork               = var.subnetwork_name
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  logging_service          = "logging.googleapis.com/kubernetes"
  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = "${var.region}-c"
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

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

resource "null_resource" "fetch_cluster" {
  depends_on = [google_container_node_pool.primary_nodes]
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name}-gke"
  }

}

resource "null_resource" "deploy_cluster" {
  depends_on = [null_resource.fetch_cluster]
  provisioner "local-exec" {
    command = "./modules/gke/autodeploy.sh"
  }
}

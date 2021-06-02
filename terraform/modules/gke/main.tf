
# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.cluster_name}-gke"
  location = "${var.region}-c"
  remove_default_node_pool = true
  initial_node_count       = var.gke_num_nodes
  network    = var.network_name
  subnetwork = var.subnetwork_name
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
    ]

    labels = {
      env = var.cluster_name
    }

    preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.cluster_name}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

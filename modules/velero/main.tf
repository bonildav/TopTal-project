resource "google_storage_bucket" "velero_backups" {
  name          = var.bucket_name
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 2
    }
    action {
      type = "Delete"
    }
  }
}

resource "null_resource" "fetch_cluster" {
  depends_on = [google_storage_bucket.velero_backups]

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name}-gke"
  }

}
resource "null_resource" "deploy_cluster" {
  depends_on = [google_storage_bucket.velero_backups]
  provisioner "local-exec" {
    command = "./modules/velero/autodeploy.sh"
  }
}

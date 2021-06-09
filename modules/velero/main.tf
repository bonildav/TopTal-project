

resource "google_storage_bucket" "velero_backups" {
  name          = var.bucket_name
  location      = "US"
  force_destroy = true
  project       = var.project_id

  lifecycle_rule {
    condition {
      age = 2
    }
    action {
      type = "Delete"
    }
  }
}

resource "time_sleep" "wait" {
  depends_on = [google_storage_bucket.velero_backups]
  create_duration = "2m"
}

resource "null_resource" "fetch_cluster" {
  depends_on = [time_sleep.wait]

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name}-gke"
  }

}
resource "null_resource" "deploy_cluster" {
  depends_on = [null_resource.fetch_cluster]
  provisioner "local-exec" {
    command = file("${path.module}/autodeploy.sh")

  }
}

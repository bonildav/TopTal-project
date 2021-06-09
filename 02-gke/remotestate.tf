terraform {
  backend "gcs" {
    bucket = "chuby-terraform-bucket"
    prefix = "gke/state"
  }
}

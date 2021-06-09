terraform {
  backend "gcs" {
    bucket = "chuby-terraform-bucket"
    prefix = "terraform/state"
  }
}

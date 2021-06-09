terraform {
  backend "gcs" {
    bucket = "chuby-terraform-bucket"
    prefix = "network/state"
  }
}

terraform {
  backend "gcs" {
    bucket = "chuby-terraform-bucket"
    prefix = "monitoring_backups_logging/state"
  }
}

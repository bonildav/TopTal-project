
resource "google_compute_instance" "instance" {
  name                      = "elk"
  machine_type              = "e2-micro"
  zone                      = "us-central1-c"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    access_config {
    }
  }
}

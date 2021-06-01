
# VPC
resource "google_compute_network" "chuby_vpc" {
  name = "vpc-network"
  auto_create_subnetworks = false
}

#Subnet
resource "google_compute_subnetwork" "chuby_subnetwork" {
 name = "terraform-subnetwork"
 ip_cidr_range = "10.10.10.0/24"
 region = "us-central1"
 network = google_compute_network.chuby_vpc.name
  }

#GCE
resource "google_compute_instance" "instance" {
  name         = "vm-instance-${count.index}"
  machine_type = "e2-micro"
  zone         = "us-central1-c"
  allow_stopping_for_update = true
  count    = 2

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = google_compute_network.chuby_vpc.id
    subnetwork = google_compute_subnetwork.chuby_subnetwork.id
    access_config {
    }
  }
}

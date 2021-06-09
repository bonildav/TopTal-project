#VPC
resource "google_compute_network" "chuby_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

#Subnet
resource "google_compute_subnetwork" "chuby_subnetwork" {
  name          = var.subnetwork_name
  ip_cidr_range = "10.10.10.0/24"
  region        = var.region
  network       = google_compute_network.chuby_vpc.name
  project                 = var.project_id
}

#Firewall Rule
resource "google_compute_firewall" "google_compute_network" {
  depends_on = [google_compute_subnetwork.chuby_subnetwork]
  name       = "terraform-firewall"
  network    = google_compute_network.chuby_vpc.name
  direction  = "INGRESS"
  project                 = var.project_id

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "9090", "9093", "9100", "10250", "3000", "32516", "22", "8081"]
  }

  source_ranges = ["10.10.10.0/24", "177.231.156.250"]
}

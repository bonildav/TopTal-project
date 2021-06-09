
#####################################################################
# Modules
#####################################################################

#Google Kubernetes Engine
module "gke" {
  source          = "./modules/gke"
  network_name    = google_compute_network.chuby_vpc.id
  subnetwork_name = google_compute_subnetwork.chuby_subnetwork.id
}


/*
#Google Compute Engine
module "elk" {
   source          = "./modules/elk"
   network_name    = google_compute_network.chuby_vpc.id
   subnetwork_name = google_compute_subnetwork.chuby_subnetwork.id
}
*/

#Bucket
module "velero" {
  depends_on  = [module.gke]
  source      = "./modules/velero"
  bucket_name = var.velero_bucket_name
}

#####################################################################
# Resources
#####################################################################

#VPC
resource "google_compute_network" "chuby_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

#Subnet
resource "google_compute_subnetwork" "chuby_subnetwork" {
  name          = var.subnetwork_name
  ip_cidr_range = "10.10.10.0/24"
  region        = var.region
  network       = google_compute_network.chuby_vpc.name
}
/*
#Firewall Rule
resource "google_compute_firewall" "google_compute_network" {
  depends_on = [google_compute_network.gke]
  name    = "terraform-firewall"
  network = google_compute_network.chuby_vpc.name
  direction = INGRESS

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "9090", "9093", "9100", "10250", "3000","32516", "22"]
  }

  source_ranges = ["10.10.10.0/24", "177.231.156.250"]
}
*/

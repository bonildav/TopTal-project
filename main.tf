
#####################################################################
# Modules
#####################################################################

#Google Kubernetes Engine
module "gke" {
  source   = "./modules/gke"
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


#Google Compute Engine
module "prometheus" {
   source          = "./modules/prometheus"
   network_name    = google_compute_network.chuby_vpc.id
   subnetwork_name = google_compute_subnetwork.chuby_subnetwork.id
 }
*/
#####################################################################
# Resources
#####################################################################
#Repo
#resource "google_sourcerepo_repository" "gceme" {
#  name = "default"
#  project = "${var.project}"
#}

#VPC
resource "google_compute_network" "chuby_vpc" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}

#Subnet
resource "google_compute_subnetwork" "chuby_subnetwork" {
  name          = "terraform-subnetwork"
  ip_cidr_range = "10.10.10.0/24"
  region        = "us-central1"
  network       = google_compute_network.chuby_vpc.name
}


output "vpc_name" {
  value = google_compute_network.chuby_vpc.name
}

output "subnet_name" {
  value = google_compute_subnetwork.chuby_subnetwork.name
}

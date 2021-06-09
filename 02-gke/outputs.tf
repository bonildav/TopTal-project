output "cluster_ca_certificate" {
  value     = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  sensitive = true
}

output "k8s_host" {
  value     = google_container_cluster.primary.endpoint
  sensitive = true
}

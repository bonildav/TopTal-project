resource "helm_release" "helm_chart" {
  create_namespace = true
  name             = var.release_name
  repository       = var.repository
  namespace        = var.ns_name
  chart            = var.chart
  values = [
    file("${path.module}/values.yaml")
  ]
}

resource "null_resource" "fetch_cluster" {
  depends_on = [helm_release.helm_chart]

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name}-gke"
  }

}

resource "null_resource" "deploy_cluster" {
  depends_on = [null_resource.fetch_cluster]
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/grafana-dashboards/node-exporter.yaml"
  }
}

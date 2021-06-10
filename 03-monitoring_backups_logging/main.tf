data "terraform_remote_state" "kubernetes" {
  backend = "gcs"
  config = {
    bucket = "chuby-terraform-bucket"
    prefix = "gke/state"
  }
}

data "google_client_config" "default" {}

terraform {
  required_version = ">= 0.13"
  required_providers {

    google = {
      source  = "hashicorp/google"
      version = "~> 3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }

  }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.kubernetes.outputs.k8s_host
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = data.terraform_remote_state.kubernetes.outputs.cluster_ca_certificate
  }
}


provider "kubernetes" {
  host                   = data.terraform_remote_state.kubernetes.outputs.k8s_host
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = data.terraform_remote_state.kubernetes.outputs.cluster_ca_certificate
}


module "prometheus_service" {
  source       = "../modules/prometheus"
  ns_name      = "monitoring"
  chart        = "kube-prometheus-stack"
  release_name = "prometheus"
  repository   = "https://prometheus-community.github.io/helm-charts"
}

module "loki_service" {
  depends_on   = [module.prometheus_service]
  source       = "../modules/loki"
  ns_name      = "loki"
  chart        = "loki-stack"
  release_name = "loki"
  repository   = "https://grafana.github.io/helm-charts"
}

module "velero_service" {
  depends_on   = [module.loki_service]
  source       = "../modules/velero"
  bucket_name  = "toptal-bucket-velero"
  cluster_name = "toptal"
}

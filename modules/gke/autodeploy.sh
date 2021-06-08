#!/usr/bin/env bash

#Author: David Bonilla
#Date: 02/06/2021
#Description: Shell script using as a startup script to install monitoring into k8s

#Variables
ns=$(kubectl get ns | grep monitoring | awk '{print $1}')
path_for_configfiles="/Users/david_bonilla/work/repos/yoiker-project/modules/gke"
helm_installed=$(helm ls -n monitoring | grep prometheus | awk '{print $1}')
helm_prometheus_pkg="prometheus-community/kube-prometheus-stack"

# Deploy anthos bank
if [ $ns == "monitoring" ]; then
  echo "Name space monitoring already created..."
  exit 0
elif [[ $helm_installed == "prometheus"  ]]; then
  echo "prometheus already installed..."
  kubectl apply -f $path_for_configfiles/grafana-dashboards
  exit 0
else
  echo "Deploying Monitoring..."
  kubectl create ns monitoring
  helm install prometheus $helm_prometheus_pkg -f $path_for_configfiles/prometheus-values.yaml -n monitoring
  echo "Deploying Dashboards..."
  kubectl apply -f $path_for_configfiles/grafana-dashboards
  exit 0
fi

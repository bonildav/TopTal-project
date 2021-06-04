#!/usr/bin/env bash

pod=$(kubectl get pod | grep frontend | awk '{print $3}')

if [ $pod == "Running"  ]; then
  echo "Bank of anthos already running..."
    exit 0
fi

# Generate secret for anthos bank
openssl genrsa -out jwtRS256.key 4096
openssl rsa -in jwtRS256.key -outform PEM -pubout -out jwtRS256.key.pub
kubectl create secret generic jwt-key --from-file=./jwtRS256.key --from-file=./jwtRS256.key.pub

# Deploy anthos bank
kubectl apply -f ./kubernetes-manifests

#waiting while the app is getting a public Ip
sleep 15
kubectl get service frontend | awk '{print $4}'

#clean keys
rm -rf jwtRS256.*

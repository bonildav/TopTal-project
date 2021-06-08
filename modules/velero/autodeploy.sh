#!/usr/bin/env bash

#Author: David Bonilla
#Date: 04/06/2021
#Description: Shell script using as a startup script to install monitoring into k8s

#Variables
BUCKET="toptal-bucket-velero"
PROJECT_ID="learning-project-288414"
SERVICE_ACCOUNT_EMAIL="velero@learning-project-288414.iam.gserviceaccount.com"
#gsutil mb gs://$BUCKET/
#Installing velero
echo "Installing Velero..."
velero install --provider gcp --plugins velero/velero-plugin-for-gcp:v1.2.0 --bucket $BUCKET --no-secret --sa-annotations iam.gke.io/gcp-service-account=velero@$PROJECT_ID.iam.gserviceaccount.com --backup-location-config serviceAccount=velero@$PROJECT_ID.iam.gserviceaccount.com --wait
echo "Granting access..."
gsutil iam ch serviceAccount:$SERVICE_ACCOUNT_EMAIL:objectAdmin gs://${BUCKET}
#Creating schedule for velero
echo "Creating daily backup for Velero..."
velero schedule create dailybackup --schedule "0 7 * * *"  --ttl 24h0m0s
echo "Creating full backup"
velero create backup fullbackup
echo "Creating anthos bank backup..."
velero create backup anthos-bank --include-namespaces prmaster

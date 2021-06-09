#!/usr/bin/env bash

#Author: David Bonilla
#Date: 02/06/2021
#Description: Shell script using as a startup script to install monitoring into k8s

#Variables
ACCESS_TOKEN=$(cat $HOME/work/repos/weebhooktoken)

#Trigger CI/CD
echo "trigger ci/cd to implement app after k8s creation"
echo "Execuring CI/CD..."
curl -X POST -H "Authorization: token $ACCESS_TOKEN" https://api.github.com/repos/bonildav/bank-of-anthos/dispatches -d '{"event_type":"app-init"}'

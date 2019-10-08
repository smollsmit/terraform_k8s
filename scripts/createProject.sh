#!/bin/bash

# ---------- Variables
id=$(openssl rand -hex 4)
billing_account=$1
project=$2
env=$3
service_account_name="terraform"
project_id=${project}-${env}-${id}
creds_path="../credentials/${project}-${env}.json"
role="owner"


gcloud projects create ${project_id} --name=${project}-${env} --labels=project=${project} 

# Get billing account: gcloud beta billing accounts list
gcloud beta billing projects link ${project_id} --billing-account ${billing_account}

# Create service account
gcloud iam service-accounts create ${service_account_name} --project ${project_id} --display-name "Terraform account for automation aim"

# Create JSON file with credentials
gcloud iam service-accounts keys create ${creds_path} --iam-account ${service_account_name}@${project_id}.iam.gserviceaccount.com

# Grant permissions
gcloud projects add-iam-policy-binding ${project_id} --member serviceAccount:${service_account_name}@${project_id}.iam.gserviceaccount.com --role roles/${role}

# Enable API
# gcloud services list --available --project ${project_id}
# gcloud services list --enable --project ${project_id}
gcloud services enable cloudresourcemanager.googleapis.com  --project ${project_id}
gcloud services enable compute.googleapis.com               --project ${project_id}
gcloud services enable serviceusage.googleapis.com          --project ${project_id}
gcloud services enable container.googleapis.com             --project ${project_id}
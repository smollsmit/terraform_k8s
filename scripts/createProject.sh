#!/bin/bash

account_billing=$1
project=$2
env=$3
project_id=${project}-${env}
creds_path="../credentials/${project_id}.json"

gcloud projects create ${project_id} --labels=project=${project} 

# Get billing account: gcloud beta billing accounts list
gcloud beta billing projects link ${project_id} --billing-account ${account_billing}

# Create service account
gcloud iam service-accounts create terraform --project ${project_id} --display-name "Terraform admin account"

# Create JSON file with credentials
gcloud iam service-accounts keys create ${creds_path} --iam-account terraform@${project_id}.iam.gserviceaccount.com

# Grant permissions
gcloud projects add-iam-policy-binding ${project_id} --member serviceAccount:terraform@${project_id}.iam.gserviceaccount.com --role roles/viewer
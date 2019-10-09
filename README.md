# Privat GKE Cluster 

## Generate user's token for auth
```
gcloud auth application-default login
```

## Get credentials
```
gcloud config set project <project_name>
gcloud container clusters get-credentials <cluster_name> --zone <zone>
```

## Run just one module
```
terraform plan -var-file ${varfile} -var="tfplan=${date}" -out ${planfile} -target module.google_dns
```
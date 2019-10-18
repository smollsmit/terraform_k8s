# Privat GKE Cluster

## Update gcloud
```
gcloud components update
```

## Generate user's token for auth
```
gcloud auth application-default login
```

## Install kubectl
```
gcloud components install kubectl
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

# VPN Configurations
### Generate PreShared key 
```
pwgen -s -N 1 -cn 64
```

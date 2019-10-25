# gcloud features

## Gcloud install (ubuntu)
```
https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
```

## Gcloud update
```
gcloud components update
```
## Generate user's token for auth
```
gcloud auth login
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

# Terrafor features
## Run just one module
```
terraform plan -var-file ${varfile} -var="tfplan=${date}" -out ${planfile} -target module.google_dns
```

# VPN Configurations
### Generate PreShared key 
```
pwgen -s -N 1 -cn 64
```
## Import IP Address 
```
terraform import -var-file=tfvars/dev.tfvars google_compute_address.ingress_ip_pub ingress-ip-pub
```
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
terraform import -var-file=.terraform/vars/variables.tfvars google_compute_address.ingress_ip_pub ingress-ip-pub
```

## Install TfLint
https://github.com/wata727/tflint/blob/master/docs/guides/config.md
```
curl -L "$(curl -s https://api.github.com/repos/wata727/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" > tflint.zip && unzip tflint.zip && rm tflint.zip

```
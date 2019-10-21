# gcloud features

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
# Variables file for environment
```
# ---------- Project vars
organization  = ""              # Doesn't use now
project_name  = ""              # Project name
env           = ""              # Project env

# ---------- Networking
vpc_network           = ""      # CIDR
public_trusted_hosts  = [""]    # List in CIDR format

# ---------- VPN
vpn_peer_ip         = ""        # IP address of remote vpn gateway
vpn_shared_secret   = ""        # PreShared key for IPSEC
vpn_remote_network  = ""        # CIDR

# ---------- Workers
frontend_node_count = 1
backend_node_count  = 1

# ---------- Users
users_devops  = []              # List of users (lookup keys from global/pub_key's folder)
```
#!/bin/bash

date=$(date '+%Y%m%d%H%M');
logfile="apply.log"
varfile=$1

terraform validate 
terraform plan -out=${date}.tfplan -var-file ${varfile}  
terraform apply ${date}.tfplan 

if [ -f "${date}.tfplan" ]; then
    echo "Generate ${date}.tfplan" >> ${logfile}
fi
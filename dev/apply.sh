#!/bin/bash

date=$(date '+%Y%m%d%H%M');
logfile="apply.log"

terraform validate 
terraform plan -out=${date}.tfplan 
#terraform apply ${date}.tfplan

if [ -f "${date}.tfplan" ]; then
    echo "Generate ${date}.tfplan" >> ${logfile}
fi
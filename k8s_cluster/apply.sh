#!/bin/bash

env=$1
date=$(date '+%Y%m%d%H%M');
logfile="tflogs/apply.log"
planfile="tfplans/${date}.tfplan"
varfile="./tfvars/${env}.tfvars"

terraform validate 
terraform plan -out=${planfile}
#terraform apply ${planfile} -var-file ${varfile} -auto-approve

if [ -f "${planfile}" ]; then
    echo "Generate ${date}.tfplan" >> ${logfile}
fi
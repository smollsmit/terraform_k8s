#!/bin/bash

env=$1
date=$(date '+%Y%m%d%H%M');
logfile="./tflogs/apply.log"
planfile="./tfplans/${date}.tfplan"
varfile="./tfvars/${env}.tfvars"

terraform validate 
#terraform plan -var-file ${varfile} -var="tfplan=${date}" -out ${planfile} -target module.enable_api
terraform plan -var-file ${varfile} -var="tfplan=${date}" -out ${planfile}
terraform apply ${planfile}

if [ -f "${planfile}" ]; then
    echo "Tfplan was generated at ${date}" >> ${logfile}
fi
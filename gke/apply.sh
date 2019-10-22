#!/bin/bash

env=$1
date=$(date '+%Y%m%d%H%M');
logfile="./tflogs/apply.log"
planfile="./tfplans/${date}.tfplan"
varfile="./tfvars/${env}.tfvars"

mkdir -p tflogs tfplans tfvars

terraform validate 
terraform plan -var-file ${varfile} -out ${planfile}
terraform apply ${planfile}

if [ -f "${planfile}" ]; then
    echo "Tfplan was successfully generated at ${date} by $USER" >> ${logfile}
fi
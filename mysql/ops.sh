#!/bin/bash

ops=$1
env=$2

date=$(date '+%Y%m%d%H%M');

rootpath="./.terraform/${env}"
logpath="${rootpath}/logs"
varpath="${rootpath}/vars"
planpath="${rootpath}/plans"
#statepath="${rootpath}/state"

mkdir -p ${logpath} ${varpath} ${planpath} #${statepath}

#cp terraform.tfstate ${statepath}/${date}.tfstate

case ${ops} in

    "apply" )

        terraform validate 
        terraform plan -var-file ${varpath}/variables.tfvars -out ${planpath}/${date}.tfplan #-state ${statepath}/terraform.tfstate
        terraform apply ${planpath}/${date}.tfplan
        
        if [ -f "${planpath}/${date}.tfplan" ]; then
            echo "Tfplan was successfully generated at ${date} by $USER" >> ${logpath}/ops.log
        fi

        ;;

    "plan" )

        terraform validate 
        terraform plan -var-file ${varpath}/variables.tfvars
        ;;

    "destroy" )

        terraform destroy -var-file ${varpath}/variables.tfvars

        echo "Role was successfully destroy at ${date} by $USER" >> ${logpath}/ops.log
        ;;

    *) echo >&2 "Invalid option: $@"; 
        exit 1;;
esac
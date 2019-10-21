#!/bin/bash

# Current stable version v2.14.3

# ---------- Variables
version_params=$1
version_default="0.12.12"
version=""
path="/tmp"

if [ -z ${version_params} ]; 
    then version=${version_default};
else version=${helm_version_params}; fi

echo "Install version ${version}"

arc_name=terraform_${version}_linux_amd64.zip

rm -rf ${path}/${arc_name}

wget -P ${path} https://releases.hashicorp.com/terraform/${version}/${arc_name}
 
cd ${path} && unzip ${arc_name}

sudo mv ${path}/terraform /usr/local/bin/terraform

terraform -uninstall-autocomplete
terraform version

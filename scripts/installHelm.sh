#!/bin/bash

# Current stable version v2.14.3

# ---------- Variables
helm_version_params=$1
helm_version_default="v2.14.3"
helm_version=""
path="/tmp"

if [ -z ${helm_version_params} ]; 
    then helm_version=${helm_version_default};
else helm_version=${helm_version_params}; fi

echo "Install HELM version ${helm_version}"

arc_name=helm-${helm_version}-linux-amd64.tar.gz

rm -rf ${path}/${arc_name}
rm -rf ${path}/linux-amd64

wget -P ${path} https://get.helm.sh/${arc_name}
cd ${path} && tar -zxvf ${arc_name}

sudo cp ${path}/linux-amd64/helm /usr/local/bin/helm

helm init 
helm version
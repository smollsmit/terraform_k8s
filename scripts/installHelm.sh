#!/bin/bash

# Current stable version v2.14.3

# ---------- Variables
version_params=$1
version_default="v2.14.3"
version=""
path="/tmp"

if [ -z ${version_params} ]; 
    then version=${version_default};
else version=${version_params}; fi

echo "Install version ${helm_version}"

arc_name=helm-${version}-linux-amd64.tar.gz

rm -rf ${path}/${arc_name}
rm -rf ${path}/linux-amd64

wget -P ${path} https://get.helm.sh/${arc_name}
cd ${path} && tar -zxvf ${arc_name}

sudo cp ${path}/linux-amd64/helm /usr/local/bin/helm

helm completion bash
source <(helm completion bash)

#helm init 
helm version

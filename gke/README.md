# k8s cluster

## Create secret for docker registry
```
kubectl create secret docker-registry registry-public-cred --docker-server=${REGISTRY_URL}  --docker-username=${REGISTRY_USER_NAME} --docker-password=${REGISTRY_USER_PASS} --docker-email=${REGISTRY_USER_EMAIL}
```
# k8s cluster

## Create secret for docker registry
```
kubectl create secret docker-registry registry-public-cred --docker-server=${REGISTRY_URL}  --docker-username=${REGISTRY_USER_NAME} --docker-password=${REGISTRY_USER_PASS} --docker-email=${REGISTRY_USER_EMAIL}
```

## Install nginx ingress
```
# helm install --name nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true
kubectl get service nginx-ingress-controller
# helm install --name nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabl
ed=true --set controller.service.loadBalancerIP=<public ip>
```
### Configure Ingress Resource to use NGINX Ingress Controller
An Ingress Resource object is a collection of L7 rules for routing inbound traffic to Kubernetes Services. Multiple rules can be defined in one Ingress Resource or they can be split up into multiple Ingress Resource manifests. The Ingress Resource also determines which controller to utilize to serve traffic. This can be set with an annotation, kubernetes.io/ingress.class, in the metadata section of the Ingress Resource. For the NGINX controller, use the value nginx as shown below:
```
annotations: kubernetes.io/ingress.class: nginx
```
On Google Kubernetes Engine, if no annotation is defined under the metadata section, the Ingress Resource uses the GCP GCLB L7 load balancer to serve traffic. This method can also be forced by setting the annotation's value to gceas shown below:
```
annotations: kubernetes.io/ingress.class: gce
```
https://github.com/gruntwork-io/terraform-google-gke/blob/v0.1.1/examples/gke-basic-tiller/main.tf

## Install helm charts
```
helm install --name rabbitmq --namespace <namespace> -f values_dev.yaml stable/rabbitmq
```
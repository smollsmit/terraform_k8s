# ---------- Namespaces
resource "kubernetes_namespace" "namespace" {

  metadata {
    name = "${var.project_name}-${var.env}"

    annotations = {
      name = "${var.project_name}-${var.env}"
    }

    labels = {
      project = "${var.project_name}"
      env     = "${var.env}"
    }
  }
}

# ---------- Install Nginx ingress controller
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "${local.helm_repo_stable}"
  chart      = "nginx-ingress"

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "controller.publishService.enabled"
    value = true
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = "${local.ingress_ip_pub}"
  }

  provisioner "local-exec" {
    command = "helm test nginx-ingress"
  }

  depends_on = [
    "null_resource.helm_init"
  ]

}

resource "helm_release" "rabbitmq" {
  name       = "rabbitmq"
  repository = "${local.helm_repo_stable}"
  chart      = "rabbitmq"
  namespace  = "${var.project_name}-${var.env}"

  values = [<<EOF
ingress:
  enabled: true
  hostName: "rmq.${var.env}.${var.cf_zone}"
  tls: true
rbacEnabled: true
rabbitmq:
  username: "${var.rmq_username}"
  password: "${var.rmq_password}"
replicas: 3
nodeSelector:
  beta.kubernetes.io/arch: amd64
volumePermissions:
  enabled: true
EOF
  ]

  depends_on = [
    "null_resource.helm_init",
    "helm_release.nginx_ingress" 
  ]

}
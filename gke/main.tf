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
  chart      = "stable/nginx-ingress"

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
  name      = "rabbitmq"
  chart     = "stable/rabbitmq"
  namespace = "${var.project_name}-${var.env}"

  set {
    name  = "ingress.enabled"
    value = true
  }

  set {
    name  = "ingress.hostName"
    value = "rmq.${var.env}.${var.cf_zone}"
  }

  set {
    name  = "rbacEnabled"
    value = true
  }

  set {
    name  = "rabbitmq.username"
    value = "${var.rmq_password}"
  }

  set {
    name  = "rabbitmq.password"
    value = "${var.rmq_password}"
  }

  set {
    name  = "rabbitmq.plugins"
    value = "rabbitmq_management"
  }

  #values = [
  #  "${file("configs/rabbitmq.yaml")}"
  #]


  provisioner "local-exec" {
    command = "helm test rabbitmq"
  }

  depends_on = [
    "null_resource.helm_init"
  ]

}
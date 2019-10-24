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
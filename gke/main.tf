# ---------- Modules
module "gke_tiller" {
  source  = "../modules/gke_tiller"
}

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
resource "helm_release" "nginx-ingress" {
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

  #set {
  #  name  = "controller.service.loadBalancerIP"
  #  value = "${data.google_compute_address.nginx-ingress-ip-pub.address}"
  #}

}
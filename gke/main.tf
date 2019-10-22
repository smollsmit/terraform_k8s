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
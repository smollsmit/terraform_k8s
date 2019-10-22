# ---------- Credential fo Docker-Registry
resource "kubernetes_secret" "registry-secret" {
  metadata {
    name      = "registry-public"
    namespace = "${var.project_name}-${var.env}"
  }

  data = {
    ".dockercfg" = "${ jsonencode(local.dockercfg) }"
  }

  type = "kubernetes.io/dockercfg"
}
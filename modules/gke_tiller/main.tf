resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }

  automount_service_account_token = true
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "${kubernetes_service_account.tiller.metadata.0.name}"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "kube-system"
    api_group = ""
  }
  
  subject {
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.tiller.metadata.0.name}"
    namespace = "${kubernetes_service_account.tiller.metadata.0.namespace}"
    api_group = ""
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "null_resource" "helm_init" {
  provisioner "local-exec" {
    command   = "helm init --service-account tiller --wait"
  }

  depends_on = [
    "kubernetes_service_account.tiller",
    "kubernetes_cluster_role_binding.tiller"
  ]

}
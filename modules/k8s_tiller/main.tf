resource "null_resource" "helm_init_command" {

  provisioner "local-exec" {
    command = "wget -P /tmp https://get.helm.sh/helm-${var.helm_version}-linux-amd64.tar.gz"

  }
}

#resource "kubernetes_namespace" "namespace" {
#
#  metadata {
#    name        = "${var.namespace_name}"
#    labels      = "${var.labels}"
#    annotations = "${var.annotations}"
#  }
#}
data "external" "credentials" {
  program = ["cat", "../globals/credentials/${var.project_name}-${var.env}.json"]
}

data "google_compute_address" "ingress_ip_pub" {
  name = "ingress-ip-pub"
}

locals {
  project_id  = "${data.external.credentials.result.project_id}"

  dockercfg = {
   "${var.docker_server}" = {
      email    = "${var.docker_email}"
      username = "${var.docker_username}"
      password = "${var.docker_password}"
    }
  }
   # ---------- IP
  ingress_ip_pub  = "${data.google_compute_address.ingress_ip_pub.address}"

}
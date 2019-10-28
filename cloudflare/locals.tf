# ---------- Get Data
data "external" "credentials" {
  program = ["cat", "../globals/credentials/${var.project_name}.json"]
}

data "google_compute_address" "ingress_ip_pub" {
  name = "ingress-ip-pub"
}

# ---------- Local Variables
locals {
  project_id      = "${data.external.credentials.result.project_id}"

  # ---------- IP
  ingress_ip_pub  = "${data.google_compute_address.ingress_ip_pub.address}"
}
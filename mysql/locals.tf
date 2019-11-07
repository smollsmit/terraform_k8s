# ---------- Get Data
data "external" "credentials" {
  program = ["cat", "../globals/credentials/${var.project_name}.json"]
}
data "google_compute_network" "compute_network" {
  name    = "${var.vpc_name}"
}

#data "google_compute_subnetwork" "dmz_subnet" {
#  name   = "${var.dmz_subnet_name}"
#}

resource "random_id" "postfix" {
  byte_length = 4
}

# ---------- Local Variables
locals {
  project_id            = "${data.external.credentials.result.project_id}"
  automation_user_email = "${data.external.credentials.result.client_email}"
  vpc                   = "${data.google_compute_network.compute_network}"
  postfix               = "${random_id.postfix.hex}"
}
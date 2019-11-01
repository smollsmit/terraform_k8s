# ---------- Get Data
data "external" "credentials" {
  program = ["cat", "../globals/credentials/${var.project_name}.json"]
}
data "google_compute_network" "compute_network" {
  name    = "${var.vpc_name}"
}

data "google_compute_subnetwork" "dmz_subnet" {
  name   = "${var.dmz_subnet_name}"
}

# ---------- Local Variables
locals {
  project_id      = "${data.external.credentials.result.project_id}"
  vpc             = "${data.google_compute_network.compute_network}"
  dmz_subnet_name = "${data.google_compute_subnetwork.dmz_subnet}"
}
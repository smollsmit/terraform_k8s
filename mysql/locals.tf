# ---------- Get Data
data "external" "credentials" {
  program = ["cat", "../globals/credentials/${var.project_name}.json"]
}

data "google_compute_network" "mysql_subnet" {
  name    = "${var.mysql_subnet_name}"
}

# ---------- Local Variables
locals {
  project_id    = "${data.external.credentials.result.project_id}"
  mysql_subnet  = "${data.google_compute_network.mysql_subnet}"
}
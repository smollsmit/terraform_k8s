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

  # ---------- Subnet 
  master_subnet   = "${cidrsubnet("${var.vpc_network}", 12, 0)}"
  node_subnet     = "${cidrsubnet("${var.vpc_network}", 8, 2)}"
  db_subnet       = "${cidrsubnet("${var.vpc_network}", 8, 4)}"
  dmz_subnet      = "${cidrsubnet("${var.vpc_network}", 8, 254)}"

  # ---------- IP
  ingress_ip_pub  = "${data.google_compute_address.ingress_ip_pub.address}"
  bastion_ip_int  = "${cidrhost("${cidrsubnet("${var.vpc_network}", 8, 254)}", 251)}"
  #lb_ip_int       = "${cidrhost("${cidrsubnet("${var.vpc_network}", 8, 254)}", 252)}"
  #mysql_ip_int    = "${cidrhost("${cidrsubnet("${var.vpc_network}", 8, 4)}", 11)}"
}
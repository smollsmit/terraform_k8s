locals {
  project_id      = "${data.external.credentials.result.project_id}"

  # ---------- Subnet 
  master_subnet   = "${cidrsubnet("${var.vpc_network}", 12, 0)}"
  node_subnet     = "${cidrsubnet("${var.vpc_network}", 8, 2)}"
  db_subnet       = "${cidrsubnet("${var.vpc_network}", 8, 4)}"
  dmz_subnet      = "${cidrsubnet("${var.vpc_network}", 8, 254)}"

  # ---------- IP
  bastion_ip_int  = "${cidrhost("${cidrsubnet("${var.vpc_network}", 8, 254)}", 251)}"
  lb_ip_int       = "${cidrhost("${cidrsubnet("${var.vpc_network}", 8, 254)}", 252)}"
  mysql_ip_int    = "${cidrhost("${cidrsubnet("${var.vpc_network}", 8, 4)}", 11)}"
}
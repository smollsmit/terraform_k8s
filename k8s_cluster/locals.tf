locals {
  project_id      = "${data.external.credentials.result.project_id}"
  master_subnet   = "${cidrsubnet("${var.vpc_subnet}", 12, 0)}"
  node_subnet     = "${cidrsubnet("${var.vpc_subnet}", 8, 2)}"
  db_subnet       = "${cidrsubnet("${var.vpc_subnet}", 8, 4)}"
  dmz_subnet      = "${cidrsubnet("${var.vpc_subnet}", 8, 254)}"
  bastion_ip_int  = "${cidrhost("${cidrsubnet("${var.vpc_subnet}", 8, 254)}", 251)}"
  lb_ip_int       = "${cidrhost("${cidrsubnet("${var.vpc_subnet}", 8, 254)}", 252)}"
}
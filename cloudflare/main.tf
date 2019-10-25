module "cloudflare" {
  source          = "../modules/cloudflare"
  project_name    = "${var.project_name}"
  env             = "${var.env}"
  cf_zone         = "${var.cf_zone}"
  ingress_ip_pub  = "${local.ingress_ip_pub}"
  cf_a_records      = "${var.cf_a_records}"
  cf_cname_records  = "${var.cf_cname_records}"
}
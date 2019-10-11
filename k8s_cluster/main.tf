# ---------- Get project_id
data "external" "credentials" {
  program = ["cat", "../globals/credentials/${var.project_name}-${var.env}.json"]
}

locals {
  project_id    = "${data.external.credentials.result.project_id}"
  master_subnet = "${cidrsubnet("${var.vpc_subnet}", 12, 0)}"
  node_subnet   = "${cidrsubnet("${var.vpc_subnet}", 8, 2)}"
  db_subnet     = "${cidrsubnet("${var.vpc_subnet}", 8, 4)}"
  dmz_subnet    = "${cidrsubnet("${var.vpc_subnet}", 8, 254)}"
  bastion_ip_int  = "${cidrhost("${cidrsubnet("${var.vpc_subnet}", 8, 254)}", 251)}"
  lb_ip_int  = "${cidrhost("${cidrsubnet("${var.vpc_subnet}", 8, 254)}", 252)}"
}
# ---------- Enable Google API
module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "3.3.0"

  project_id    = "${local.project_id}"
  activate_apis = "${var.api_services}"

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

# ---------- Modules
module "k8s_cluster" {
  source        = "../modules/k8s_cluster"
  project       = "${var.project_name}"
  project_id    = "${local.project_id}"
  env           = "${var.env}"
  location      = "${var.zone}"

  network       = "${google_compute_network.vpc.name}"
  subnetwork    = "${local.node_subnet}"
  
  master_subnet = "${local.master_subnet}"
  node_subnet   = "${local.node_subnet}"
  

  node_pools = [
    {
      name              = "frontend-pool"
      machine_type      = "f1-micro"
      node_count        = "${var.frontend_node_count}" 
      disk_size_gb      = 30
      disk_type         = "pd-standard"
      preemptible       = true
    },
    {
      name              = "backend-pool"
      machine_type      = "g1-small"
      node_count        = "${var.backend_node_count}"
      disk_size_gb      = 30
      disk_type         = "pd-standard"
      preemptible       = true
    },
  ]
}
module "google_dns" {
  source              = "../modules/google_dns"
  project_name        = "${var.project_name}"
  env                 = "${var.env}"
  dns_name            = "${var.env}.${var.project_name}.local" 
  visibility_network  = "${google_compute_network.vpc.self_link}"
}
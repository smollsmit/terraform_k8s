# ---------- Get project_id
data "external" "credentials" {
  program = ["cat", "../credentials/${var.project_name}-${var.env}.json"]
}

locals {
  project_id = "${data.external.credentials.result.project_id}"
}

# ---------- Modules
module "k8s_cluster" {
  source        = "../modules/k8s_cluster"
  project       = "${var.project_name}"
  project_id    = "${local.project_id}"
  env           = "${var.env}"
  location      = "${var.zone}"

  network       = "${google_compute_network.vpc.name}"
  subnetwork    = "${google_compute_subnetwork.node_subnet.name}"
  
  master_subnet = "${var.master_subnet}"
  node_subnet   = "${var.node_subnet}"

  node_pools = [
    {
      name              = "frontend-pool"
      machine_type      = "f1-micro"
      node_count        = 1 
      disk_size_gb      = 30
      disk_type         = "pd-standard"
      preemptible       = true
    },
    {
      name              = "backend-pool"
      machine_type      = "g1-small"
      node_count        = 1
      disk_size_gb      = 30
      disk_type         = "pd-standard"
      preemptible       = true
    },
  ]
}

module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "3.3.0"

  project_id    = "${local.project_id}"
  activate_apis = "${var.api_services}"

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

module "google_dns" {
  source              = "../modules/google_dns"
  project_name        = "${var.project_name}"
  env                 = "${var.env}"
  dns_name            = "${var.env}.${var.project_name}.local" 
  visibility_network  = "${google_compute_network.vpc.self_link}"
}
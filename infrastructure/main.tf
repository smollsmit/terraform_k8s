# ---------- Get project_id
data "external" "credentials" {
  program = ["cat", "../globals/credentials/${var.project_name}-${var.env}.json"]
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
  subnetwork    = "${google_compute_subnetwork.node_subnet.name}"
  
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
  dns_zone_name       = "${var.env}.${var.project_name}.local" 
  visibility_network  = "${google_compute_network.vpc.self_link}"
}

module "google_vm" {
  source        = "../modules/google_vm"
  project_name  = "${var.project_name}"
  env           = "${var.env}"
  
  node_pools = [
    {
      count    = "1"
      name          = "bastion"
      dns_zone_name = "${var.env}.${var.project_name}.local"
      machine_type  = "f1-micro"
      disk_size_gb  = 10
      disk_type     = "pd-standard"
      ssh_users     = ""
      packages      = ""
      subnetwork    = "${google_compute_subnetwork.dmz_subnet.name}"
      ip_int        = "${local.bastion_ip_int}"
      ip_pub        = "${google_compute_address.bastion-ip-pub.address}"
      tags          = ["allow-ssh-from-trusted-in","allow-all-from-internal-in"]
      preemptible   = true
    },
    {
      count    = "1"
      name          = "mysql-master"
      dns_zone_name = "${var.env}.${var.project_name}.local" 
      machine_type  = "f1-micro"
      disk_size_gb  = 10
      disk_type     = "pd-standard"
      ssh_users     = ""
      packages      = ""
      subnetwork    = "${google_compute_subnetwork.db_subnet.name}"
      ip_int        = "${local.mysql_ip_int}"
      ip_pub        = ""
      tags          = []
      preemptible   = true
    },
  ]
}
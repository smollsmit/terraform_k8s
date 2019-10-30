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
## Create private Kubernetes cluster with the predefined parameters
#module "google_k8s" {
#  source        = "../modules/google_k8s"
#  project_name  = "${var.project_name}"
#  project_id    = "${local.project_id}"
#  env           = "${var.env}"
#  location      = "${var.zone}"
#
#  network       = "${google_compute_network.vpc.name}"
#  subnetwork    = "${google_compute_subnetwork.node_subnet.name}"
#  
#  master_subnet = "${local.master_subnet}"
#  node_subnet   = "${local.node_subnet}"
#  
#
#  node_pools = [
#    {
#      name              = "backend-pool"
#      machine_type      = "g1-small"
#      node_count        = "${var.backend_node_count}"
#      disk_size_gb      = 20
#      disk_type         = "pd-standard"
#      preemptible       = false 
#    },
#  ]
#}

module "google_dns" {
  source              = "../modules/google_dns"
  organization        = "${var.organization}"
  env                 = "${var.env}"
  dns_zone_name       = "${var.env}.${var.organization}.local" 
  visibility_network  = "${google_compute_network.vpc.self_link}"
}

module "google_vm" {
  source        = "../modules/google_vm"
  organization  = "${var.organization}"
  project_name  = "${var.project_name}"
  env           = "${var.env}"
  
  node_pools = [
    {
      name            = "bastion"
      dns_zone_name   = "${var.env}.${var.organization}.local"
      machine_type    = "f1-micro"
      disk_size_gb    = 10
      disk_type       = "pd-standard" # pd-standard or pd-ssd
      ssh_users       = ""
      packages        = ""
      subnetwork      = "${google_compute_subnetwork.dmz_subnet.name}"
      ip_int          = "${local.bastion_ip_int}"
      ip_pub_enabled  = true # assign static IP address if true and ip_pub_value set
      ip_pub_value    = "${google_compute_address.bastion_ip_pub.address}"
      tags            = ["allow-ssh-from-trusted","allow-all-internal"]
      preemptible     = true
    },
    #{
    #  count           = "1"
    #  name            = "mysql-master"
    #  dns_zone_name   = "${var.env}.${var.organization}.local" 
    #  machine_type    = "f1-micro"
    #  disk_size_gb    = 10
    #  disk_type       = "pd-standard"
    #  ssh_users       = ""
    #  packages        = ""
    #  subnetwork      = "${google_compute_subnetwork.db_subnet.name}"
    #  ip_int          = "${local.mysql_ip_int}"
    #  ip_pub_enabled  = false 
    #  ip_pub_value    = ""
    #  tags            = ["allow-all-internal"]
    #  preemptible     = true
    #},
  ]
}

#module "google_vpn" {
#  source              = "../modules/google_vpn"
#  project_name        = "${var.project_name}"
#  env                 = "${var.env}"
#  network             = "${google_compute_network.vpc.self_link}"
#  vpn_peer_ip         = "${var.vpn_peer_ip}"
#  vpn_shared_secret   = "${var.vpn_shared_secret}"
#  vpn_remote_network  = "${var.vpn_remote_network}"
#}
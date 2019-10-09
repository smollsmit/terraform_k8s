# ---------- Get project_id
data "external" "credentials" {
  program = ["cat", "../credentials/${var.project_name}-${var.env}.json"]
}

locals {
  project_id = data.external.credentials.result.project_id
}

# ---------- Modules
module "k8s_cluster" {
  source      = "../modules/k8s_cluster"
  project     = var.project_name
  project_id  = local.project_id
  env         = var.env
  location    = var.zone

  network       = google_compute_network.vpc.name
  subnetwork    = google_compute_subnetwork.node_subnet.name
  
  master_subnet = var.master_subnet
  node_subnet   = var.node_subnet

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

module "google_api" {
  source = "../modules/google_api"
  project_id  = local.project_id
  api_services = var.api_services
}

module "google_dns" {
  source                  = "../modules/google_dns"
  name                    = "TEST"
  enable_dns_managed_zone = true
  description             = "Local dns zone for ${var.env} environment"
  dns_name                = "linux-notes.org."
  enable_dns_record_set   = true
  managed_zone            = "test-dns-mz-stage"
  rrdatas                 = ["8.8.8.8"]
}
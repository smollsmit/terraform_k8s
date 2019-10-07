# ---------- Get project_id
data "external" "credentials" {
  program = ["cat", "../credentials/${var.project_name}-${var.env}.json"]
}

# ---------- Enable API
resource "google_project_services" "project_api" {
  project   = data.external.credentials.result.project_id

  services  = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]

}

# ---------- Modules
module "create_k8s_cluster" {
  source      = "../modules/create_k8s_cluster"
  project     = var.project_name
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
module "k8s-cluster" {
  source      = "../modules/k8s-cluster"
  project     = var.project
  env         = var.env
  location    = var.zone

  network     = google_compute_network.vpc.name

  node_pools = [
    {
      name              = "frontend-pool"
      machine_type      = "f1-micro"
      node_count        = 1 
      disk_size_gb      = 30
      disk_type         = "pd-standard"
    },
    {
      name              = "backend-pool"
      machine_type      = "g1-small"
      node_count        = 1
      disk_size_gb      = 30
      disk_type         = "pd-standard"
    },
  ]
}
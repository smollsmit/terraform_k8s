resource "google_project_service" "kubernetes-engine-api" {
  project = var.project
  service = "container.googleapis.com"
}

resource "google_project_service" "compute-engine-api" {
  project = var.project
  service = "compute.googleapis.com"
}

module "k8s-cluster" {
  source      = "../modules/k8s-cluster"
  project     = var.project
  env         = var.env
  location    = var.region
  network     = google_compute_subnetwork.k8s-cluster-subnet.name
  subnetwork  = var.k8s-cluster-subnet

  # This setting will make the cluster private
  #enable_private_nodes = "true"
  # To make testing easier, we keep the public endpoint available. In production, we highly recommend restricting access to only within the network boundary, requiring your users to use a bastion host or VPN.
  #disable_public_endpoint = "false"
}


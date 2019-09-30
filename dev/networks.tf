resource "google_compute_subnetwork" "node_subnet" {
  name          = "${format("%s","${google_compute_network.vpc.name}-node-subnet")}"
  project       = var.project_id
  ip_cidr_range = var.node_subnet
  network       = google_compute_network.vpc.name
  region        = var.region
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "${format("%s","${google_compute_network.vpc.name}-db-subnet")}"
  project       = var.project_id
  ip_cidr_range = var.db_subnet
  network       = google_compute_network.vpc.name
  region        = var.region
}
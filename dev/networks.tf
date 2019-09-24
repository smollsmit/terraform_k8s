resource "google_compute_subnetwork" "k8s-cluster-subnet" {
  name          = "${format("%s","${google_compute_network.vpc.name}-k8s-cluster-subnet")}"
  project       = var.project
  ip_cidr_range = var.k8s-cluster-subnet
  network       = google_compute_network.vpc.name
  region        = var.region
}
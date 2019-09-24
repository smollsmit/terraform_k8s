locals {
  cluster-name      = google_container_cluster.k8s-cluster.name
  cluster-location  = google_container_cluster.k8s-cluster.location
  cluster-endpoint  = google_container_cluster.k8s-cluster.endpoint
}
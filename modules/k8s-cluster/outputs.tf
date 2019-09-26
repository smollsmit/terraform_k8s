output "name" {
  description = "Cluster name"
  value       = google_container_cluster.k8s-cluster.name
}

output "location" {
  description = "Cluster location"
  value       = google_container_cluster.k8s-cluster.location
}

output "endpoint" {
  description = "Cluster endpoint"
  value       = google_container_cluster.k8s-cluster.endpoint
}

output "master-version" {
  description = "Master version"
  value       = google_container_cluster.k8s-cluster.master_version
}
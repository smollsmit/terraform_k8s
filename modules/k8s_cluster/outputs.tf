output "name" {
  description = "Cluster name"
  value       = google_container_cluster.k8s_cluster.name
}

output "location" {
  description = "Cluster location"
  value       = google_container_cluster.k8s_cluster.location
}

output "endpoint" {
  description = "Cluster endpoint"
  value       = google_container_cluster.k8s_cluster.endpoint
}

output "master_version" {
  description = "Master version"
  value       = google_container_cluster.k8s_cluster.master_version
}
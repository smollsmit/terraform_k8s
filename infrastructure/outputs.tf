# ---------- Project Variables
output "project_id" {
  value = "${local.project_id}"
}

# ---------- GKE cluster
output "cluster_name" {
  value = "${module.k8s_cluster.name}"
}

output "cluster_location" {
  value = "${module.k8s_cluster.location}"
}

output "cluster_endpoint" {
  value = "${module.k8s_cluster.endpoint}"
}
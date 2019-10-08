# ---------- Project Variables
output "project_id" {
  value = local.project_id
}

# ---------- GKE cluster
output "cluster_name" {
  value = module.create_k8s_cluster.name
}

output "cluster_location" {
  value = module.create_k8s_cluster.location
}

output "cluster_endpoint" {
  value = module.create_k8s_cluster.endpoint
}

# ---------- Bastion
output "bastion_public_ip" {                                                                                                                                                                                              
    value = google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip
}
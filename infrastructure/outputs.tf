# ---------- Project Variables
output "project_id" {
  value = "${local.project_id}"
}

# ---------- GKE cluster
output "cluster_name" {
  value = "${module.google_k8s.name}"
}

output "cluster_location" {
  value = "${module.google_k8s.location}"
}

output "cluster_endpoint" {
  value = "${module.google_k8s.endpoint}"
}

# ---------- VMs
output "vm_public_ip" {
  value = "${module.google_vm.vm_public_ip}"
}
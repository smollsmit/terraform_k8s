# ---------- Bastion
output "vm_public_ip" {                                                                                                                                                                                              
  value = "${zipmap(google_compute_instance.compute_instance[*].id, google_compute_instance.compute_instance[*].network_interface.0.access_config[*].nat_ip)}"
}
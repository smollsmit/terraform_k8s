# ---------- Bastion
output "vm_public_ip" {                                                                                                                                                                                              
  value = "${google_compute_instance.compute_instance[*].network_interface}"
}
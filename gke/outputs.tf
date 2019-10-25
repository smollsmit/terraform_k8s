output "ingress_ip_pub" {
  value = "${data.google_compute_address.ingress_ip_pub.address}"
}

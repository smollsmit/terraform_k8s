output "vpn_ip_pub" {
  value = "${google_compute_address.vpn_ip_pub.address}"
}
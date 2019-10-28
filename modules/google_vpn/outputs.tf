output "vpn_public_ip" {
  value = "${google_compute_address.vpn-ip-pub.address}"
}
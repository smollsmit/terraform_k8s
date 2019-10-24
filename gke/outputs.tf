output "nginx_ingress_ip_pub" {
  value = "${data.google_compute_address.nginx-ingress-ip-pub}"
}

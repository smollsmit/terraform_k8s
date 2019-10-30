# ---------- IP Address
resource "google_compute_address" "vpn-ip-pub" {
  name = "vpn-ip-pub"
  
  #lifecycle {
  #  prevent_destroy = true
  #}

}

resource "google_compute_vpn_gateway" "vpn_gateway" {
  name    = "${var.project_name}-vpn-gateway"
  network = "${var.network}"
}

# ---------- Forwarding rules
resource "google_compute_forwarding_rule" "forwarding_rule_esp" {
  name        = "forwarding-rule-esp"
  ip_protocol = "ESP"
  ip_address  = "${google_compute_address.vpn-ip-pub.address}"
  target      = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
}

resource "google_compute_forwarding_rule" "forwarding_rule_udp_500" {
  name        = "forwarding-rule-udp-500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${google_compute_address.vpn-ip-pub.address}"
  target      = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
}

resource "google_compute_forwarding_rule" "forwarding_rule_udp_4500" {
  name        = "forwarding-rule-udp-4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${google_compute_address.vpn-ip-pub.address}"
  target      = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
}

# ---------- VPN Tunnel
resource "google_compute_vpn_tunnel" "vpn_tunnel" {
  name          = "${var.project_name}-vpn-tunnel"
  peer_ip       = "${var.vpn_peer_ip}"
  shared_secret = "${var.vpn_shared_secret}"
  ike_version   = "2"
  
  local_traffic_selector  = ["0.0.0.0/0"]   # For policy based ["${var.vpc_network}"]
  remote_traffic_selector = ["0.0.0.0/0"]   # For policy based ["${var.vpn_remote_network}"]

  target_vpn_gateway      = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
  
  depends_on = [
    "google_compute_forwarding_rule.forwarding_rule_esp",
    "google_compute_forwarding_rule.forwarding_rule_udp_500",
    "google_compute_forwarding_rule.forwarding_rule_udp_4500",
  ]
}

# ---------- VPN Rotes to remote Network
resource "google_compute_route" "compute_route" {
  name        = "${var.project_name}-vpn-route"
  dest_range  = "${var.vpn_remote_network}"
  network     = "${var.network}"
  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.vpn_tunnel.self_link}"
  priority    = 100
}
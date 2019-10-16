# ---------- IP
resource "google_compute_global_address" "lb-ip-pub" {
  name = "lb-ip-pub"
}

## ---------- Forwarding rules
#resource "google_compute_global_forwarding_rule" "forwarding-rule-http" {
#  name        = "${var.project_name}-${var.env}-forwarding-rule-http"
#  ip_address  = google_compute_global_address.lb-ip-pub.address
#  ip_protocol = "TCP"
#  port_range  = "80"
#  target      = google_compute_target_http_proxy.http-proxy.self_link
#}
#
## ---------- Proxy Rules
#resource "google_compute_target_http_proxy" "http-proxy" {
#  name        = "${var.project_name}-${var.env}-http-proxy"
#  url_map     = google_compute_url_map.url-map.self_link
#}
#
## ---------- URL Maps
#resource "google_compute_url_map" "url-map" {
#  name = "${var.project_name}-${var.env}-url-map"
#
#  # Do not add host/path rules for applications here. Use Ingress resources.
#  default_service = google_compute_backend_service.backend-service.self_link
#}
#
## ---------- Backend service
#resource "google_compute_backend_service" "backend-service" {
#  name        = "${var.project_name}-${var.env}-backend-service"
#
#  protocol         = "HTTP"
#  port_name        = "http"
#  session_affinity = "NONE"
#  timeout_sec      = "60"
#
#  backend {
#    group = module.k8s_cluster.instance_group
#  }
#
#  health_checks = [google_compute_health_check.ingress-health-check.self_link]
#}
#
## Ingress HTTP Health Check
#resource "google_compute_health_check" "ingress-health-check" {
#  name        = "${var.project_name}-${var.env}-ingress-health-check"
#  description = "Health check for Ingress controller"
#
#  timeout_sec        = 5
#  check_interval_sec = 5
#
#  healthy_threshold   = 2
#  unhealthy_threshold = 4
#
#  http_health_check {
#    port         = 10254
#    request_path = "/healthz"
#  }
#}
#
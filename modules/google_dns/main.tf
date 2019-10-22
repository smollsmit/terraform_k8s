# ---------- Create google dns managed zone
resource "google_dns_managed_zone" "private_zone_local" {
  name        = "${var.project_name}-${var.env}"
  dns_name    = "${var.dns_zone_name}."
  description = "Local dns zone for ${var.env} environment" 

  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = "${var.visibility_network}"
    }
  }

  #lifecycle {
  #    ignore_changes = []
  #    create_before_destroy = true
  #}
}
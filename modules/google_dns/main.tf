# ---------- Create google dns managed zone
resource "google_dns_managed_zone" "private_zone_local" {
  name        = "${var.project_name}-${var.env}"
  dns_name    = "${var.dns_name}."
  description = "Local dns zone for ${var.env} environment" 

  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = "${var.visibility_network}"
    }
  }

  lifecycle {
      ignore_changes = []
      create_before_destroy = true
  }
}

# ---------- Create google dns record set
resource "google_dns_record_set" "dns_record_set" {
  name            = "bastion.${google_dns_managed_zone.private_zone_local.dns_name}"
  type            = "A"
  ttl             = "300"

  managed_zone    = "${google_dns_managed_zone.private_zone_local.name}"
    
  rrdatas         = ["10.0.0.250"]

  lifecycle {
    ignore_changes = []
    create_before_destroy = true
  }
} 
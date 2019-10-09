# ---------- Create google dns managed zone
resource "google_dns_managed_zone" "local_zone" {
  name        = "${var.project_name}-${var.env}"
  dns_name    = "${var.dns_name}."
  description = "Local dns zone for ${var.env} environment" 

  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = var.visibility_network
    }
  }

  lifecycle {
      ignore_changes = []
      create_before_destroy = true
  }
}

## ---------- Create google dns record set
#resource "google_dns_record_set" "dns_record_set" {
#    count           = "${var.enable_dns_record_set && length(var.type) >0 && length(var.managed_zone) >0 && length(var.rrdatas) >0 ? 1 : 0}"
#
#    name            = "${lower(var.name)}.${lower(var.dns_name)}."
#    project         = "${var.project}"
#    type            = "${var.type}"
#    ttl             = "${var.ttl}"
#
#    managed_zone    = "${var.managed_zone}"
#    
#    rrdatas         = ["${var.rrdatas}"]
#
#    lifecycle {
#        ignore_changes = []
#        create_before_destroy = true
#    }
#} 
#
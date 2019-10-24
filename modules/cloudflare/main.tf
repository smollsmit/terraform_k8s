resource "cloudflare_zone" "zone" {
    zone = "${var.cf_zone}"
}

resource "cloudflare_zone_settings_override" "zone_settings" {
  zone_id = "${cloudflare_zone.zone.id}"

  settings {
    ssl     = "flexible"
    tls_1_3 = "on"
  }

}

resource "cloudflare_record" "a_records" {
  zone_id = "${cloudflare_zone.zone.id}"
  name    = "@"
  value   = "${var.ingress_ip_pub}"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "wildcard_records" {
  zone_id = "${cloudflare_zone.zone.id}"
  name    = "*.${var.env}"
  value   = "${var.ingress_ip_pub}"
  type    = "A"
  proxied = false
}
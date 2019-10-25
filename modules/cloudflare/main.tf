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
  count   ="${length(var.cf_a_records)}"
  zone_id = "${cloudflare_zone.zone.id}"
  name    = "${var.cf_a_records[count.index]["name"]}"
  value   = "${var.cf_a_records[count.index]["value"] == "" ? var.ingress_ip_pub : var.cf_a_records[count.index]["value"]}" 
  type    = "A"
  proxied = "${var.cf_a_records[count.index]["proxied"]}"
}

resource "cloudflare_record" "cname_records" {
  count   ="${length(var.cf_cname_records)}"
  zone_id = "${cloudflare_zone.zone.id}"
  name    = "${var.cf_cname_records[count.index]["name"]}"
  value   = "${var.cf_cname_records[count.index]["value"] == "" ? var.cf_zone : var.cf_cname_records[count.index]["value"]}" 
  type    = "CNAME"
  proxied = "${var.cf_cname_records[count.index]["proxied"]}"

  depends_on = [
    "cloudflare_record.a_records"
  ]
}
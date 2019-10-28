output "cf_zone_name" {
  value = "${cloudflare_zone.zone.zone}"
}

output "cf_zone_id" {
  value = "${cloudflare_zone.zone.id}"
}
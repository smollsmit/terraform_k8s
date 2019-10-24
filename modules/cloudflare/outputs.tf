output "zone_name" {
  value = "${cloudflare_zone.zone.zone}"
}

output "zone_id" {
  value = "${cloudflare_zone.zone.id}"
}
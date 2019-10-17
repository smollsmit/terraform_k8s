output "managed_zone_name" {
  description = "Managed zone name"
  value       = "${google_dns_managed_zone.private_zone_local.name}"
}

output "managed_zone_dns_name" {
  description = "Managed zone name"
  value       = "${google_dns_managed_zone.private_zone_local.dns_name}"
}
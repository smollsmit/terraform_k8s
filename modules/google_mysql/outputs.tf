# ---------- MySQL
output "connection_name" {
  value = "${google_sql_database_instance.mysql_database_instance.connection_name}"
}

output "ip_address_type" {
  value = "${google_sql_database_instance.mysql_database_instance.ip_address.0.type}"
}

output "ip_address" {
  value = "${google_sql_database_instance.mysql_database_instance.private_ip_address}"
}
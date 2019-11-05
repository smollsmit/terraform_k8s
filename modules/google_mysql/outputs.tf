# ---------- MySQL
output "master_connection_name" {
  value = "${google_sql_database_instance.mysql_database_instance_master.connection_name}"
}

output "master_ip_address_type" {
  value = "${google_sql_database_instance.mysql_database_instance_master.ip_address.0.type}"
}

output "master_ip_address" {
  value = "${google_sql_database_instance.mysql_database_instance_master.private_ip_address}"
}

output "failover_connection_name" {
  value = "${google_sql_database_instance.mysql_database_instance_failover[*].connection_name}"
}

output "failover_ip_address_type" {
  value = "${google_sql_database_instance.mysql_database_instance_failover[*].ip_address.0.type}"
}

output "failover_ip_address" {
  value = "${google_sql_database_instance.mysql_database_instance_failover[*].private_ip_address}"
}
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

output "slave_connection_name" {
  value = "${google_sql_database_instance.mysql_database_instance_slave.connection_name}"
}

output "slave_ip_address_type" {
  value = "${google_sql_database_instance.mysql_database_instance_slave.ip_address.0.type}"
}

output "slave_ip_address" {
  value = "${google_sql_database_instance.mysql_database_instance_slave.private_ip_address}"
}
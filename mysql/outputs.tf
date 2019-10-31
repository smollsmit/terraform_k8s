# ---------- Project Variables
output "project_id" {
  value = "${local.project_id}"
}

output "Project_vpc_name" {
  value = "${local.vpc.name}"
}

# ---------- MySQL
output "mysql_connection_name" {
  value = "${module.google_mysql.connection_name}"
}

output "mysql_ip_address_type" {
  value = "${module.google_mysql.ip_address_type}"
}

output "mysql_ip_address" {
  value = "${module.google_mysql.ip_address}"
}
# ---------- Project Variables
output "project_id" {
  value = "${local.project_id}"
}
output "project_vpc_name" {
  value = "${local.vpc.name}"
}
#output "dmz_subnet" {
#  value = "${local.dmz_subnet_name}"
#}

# ---------- MySQL
output "mysql_connection_name" {
  value = "${module.google_mysql.master_connection_name}"
}
output "mysql_master_ip_address_type" {
  value = "${module.google_mysql.master_ip_address_type}"
}
output "mysql_master_ip_address" {
  value = "${module.google_mysql.master_ip_address}"
}
#output "mysql_failover_ip_address_type" {
#  value = "${module.google_mysql.failover_ip_address_type}"
#}
#output "mysql_failover_ip_address" {
#  value = "${module.google_mysql.failover_ip_address}"
#}
# ---------- Generate postfix for DB instance's name
resource "random_id" "db_postfix" {
  byte_length = 4
}

# ---------- Create peering network
resource "google_compute_global_address" "peering_ip_address" {
  provider = "google-beta"

  name          = "peering-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  network       = "${var.network}"
  prefix_length = 16 
  #address = ""
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = "google-beta"

  network       = "${var.network}" 
  service       = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.peering_ip_address.name}"]
}

# ---------- MySQL Instance
resource "google_sql_database_instance" "mysql_database_instance" {
  name = "mysql-online-${random_id.db_postfix.hex}"
  database_version  = "MYSQL_5_7"

  settings {
    tier              = "${var.tier}"
    replication_type  = "SYNCHRONOUS"
 
    disk_size         = "${var.disk_size}" 
    disk_type         = "${var.disk_type}"

    backup_configuration {
      enabled    = "${var.backup_enable}"
      start_time = "17:00"
    }

    ip_configuration {

      ipv4_enabled = false 
      private_network = "${var.network}"

      #authorized_networks {
      #    name  = "bastion"
      #    value = "10.90.254.251"
      #}

    }

    database_flags {
      name  = "slow_query_log"
      value = "on"
    }

    database_flags {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  }

  #lifecycle {
  #  prevent_destroy = true
  #}

  depends_on = [
    "google_service_networking_connection.private_vpc_connection"
  ]

}
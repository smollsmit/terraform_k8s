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
  #address      = ""
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider  = "google-beta"

  network   = "${var.network}" 
  service   = "servicenetworking.googleapis.com"
  
  reserved_peering_ranges = ["${google_compute_global_address.peering_ip_address.name}"]
}

# ---------- Create Bucket for DB Backup
resource "google_storage_bucket" "db_bucket" {
  name     = "db-${var.project_name}-${random_id.db_postfix.hex}"

  lifecycle {
    ignore_changes = []
    create_before_destroy = true
  }

  labels = {
    env = "${var.env}"
  }

  force_destroy = true

}

# ---------- Upload DB to Bucket
resource "google_storage_bucket_object" "bucket_object" {
  name   = "base.sql.gz"
  source = "${var.mysql_dump_src}"
  bucket = "${google_storage_bucket.db_bucket.name}"

  depends_on = [
    "google_storage_bucket.db_bucket"
  ]

}

# ---------- Create MySQL Instance (main)
resource "google_sql_database_instance" "mysql_database_instance_master" {
  name              = "mysql-${var.project_name}-master-${random_id.db_postfix.hex}"
  database_version  = "MYSQL_5_7"

  settings {
    tier              = "${var.tier}"
    replication_type  = "SYNCHRONOUS"
 
    backup_configuration {
      binary_log_enabled  = "true"
      enabled             = "${var.backup_enabled}"
      start_time          = "17:00"
    }

    user_labels = {
      env = "${var.env}"
      type = "master"
    }

    ip_configuration {

      ipv4_enabled = false 
      private_network = "${var.network}"

      #authorized_networks {
      #  name  = "dmz-subnet"
      #  value = ""
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
  #
  #  ignore_changes = [
  #    settings[0].disk_size
  #  ]
  #}

  depends_on = [
    "google_service_networking_connection.private_vpc_connection"
  ]

}

resource "google_sql_database_instance" "mysql_database_instance_failover" {
  name                  = "mysql-${var.project_name}-failover-${random_id.db_postfix.hex}"
  count                 = "${var.failover_enabled == true ? 1 : 0}"
  database_version      = "MYSQL_5_7"
  master_instance_name  = "${google_sql_database_instance.mysql_database_instance_master.name}"

  replica_configuration {
    connect_retry_interval = "30"
    failover_target        = "true"
    #dump_file_path         = "${var.mysql_dump_path}"
  }

  settings {
    tier              = "${var.tier}"
    replication_type  = "SYNCHRONOUS"

    user_labels = {
      env = "${var.env}"
      type = "failover"
    }

    crash_safe_replication = true

    ip_configuration {

      ipv4_enabled    = false 
      private_network = "${var.network}"

    }

    database_flags {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  }

  #lifecycle {
  #  prevent_destroy = true
  #
  #  ignore_changes = [
  #    settings[0].disk_size
  #  ]
  #}

  depends_on = [
    "google_service_networking_connection.private_vpc_connection",
    "google_sql_database_instance.mysql_database_instance_master"
  ]

}

# ---------- Create Users
resource "random_id" "user-password" {
  keepers = {
    name = "google_sql_database_instance.mysql_database_instance_master.name"
  }

  byte_length = 8
  depends_on  = ["google_sql_database_instance.mysql_database_instance_master"]
}
resource "google_sql_user" "mysql_users" {
  count       = "${length(var.mysql_users)}"
  name        = "${var.mysql_users[count.index]["name"]}"
  password    = "${lookup(var.mysql_users[count.index], "password", random_id.user-password.hex,)}"
  host        = "${lookup(var.mysql_users[count.index], "host", var.mysql_host)}"
  instance    = "${google_sql_database_instance.mysql_database_instance_master.name}"
  
  depends_on  = ["google_sql_database_instance.mysql_database_instance_failover"]

}
# ---------- Create DB
resource "google_sql_database" "sql_database" {
  instance = "${google_sql_database_instance.mysql_database_instance_master.name}"
  name     = "${var.project_name}"
}



# ---------- Import DB to MySQL Instance
#resource "null_resource" "import_database" {
#
#  provisioner "local-exec" {
#    command = "gcloud sql import sql ${google_sql_database_instance.mysql_database_instance_master.name} ${google_storage_bucket.mysql_backup.name}/${var.mysql_dump_path} --database=${var.project_name} --quiet"
#  }
# 
#  depends_on = [
#    "google_sql_database.sql_database",
#    "google_storage_bucket.db_bucket"
#  ]
#}
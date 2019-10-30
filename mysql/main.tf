module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "3.3.0"

  project_id    = "${local.project_id}"
  activate_apis = "${var.api_services}"

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

# ---------- Modules
#module "google_mysql" {
#  source              = "../modules/google_mysql"
#  organization        = "${var.organization}"
#  project_name        = "${var.project_name}"
#  env                 = "${var.env}"
#}

resource "google_sql_database_instance" "mysql_database_instance" {
  name             = "mysql-online"
  #region            = "${var.region}"
  database_version  = "MYSQL_5_7"

  settings {
    tier              = "db-f1-micro"
    replication_type  = "SYNCHRONOUS"
 
    disk_size         = 8
    disk_type         = "PD_SSD"

    backup_configuration {
      enabled    = false
      start_time = "17:00"
    }

    ip_configuration {
      ipv4_enabled = true
      #private_network = "${local.mysql_subnet.self_link}"
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

  lifecycle {
    prevent_destroy = true
  }

}
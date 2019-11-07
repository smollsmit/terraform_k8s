module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "3.3.0"

  project_id    = "${local.project_id}"
  activate_apis = "${var.api_services}"

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

# ---------- Modules
module "google_buckt" {
  source              = "../modules/google_buckt"
  versioning_enabled  = false    
  location            = "${var.location}"

  bucket_name         = "db-${var.project_name}-${local.postfix}"
  bucket_user_email   = "${local.automation_user_email}"
  bucket_user_role    = "roles/storage.objectAdmin"

  file_local_path     = "${var.file_local_path}"
  file_remote_path    = "${var.file_remote_path}"
  file_upload_name    = "${var.file_upload_name}"

  labels = {
    project = "${var.project_name}"
    env     = "${var.env}"
  }

}

module "google_mysql" {
  source                      = "../modules/google_mysql"
  network                     = "${data.google_compute_network.compute_network.self_link}"

  master_instance_name        = "mysql-${var.project_name}-master-${local.postfix}"
  master_tier                 = "db-f1-micro"
  master_public_ip_enabled    = false
  master_backup_enabled       = true
  master_backup_time          = "23:00"

  failover_instance_name      = "mysql-${var.project_name}-failover-${local.postfix}"
  failover_tier               = "db-f1-micro"
  failover_public_ip_enabled  = false
  failover_enabled            = true

  labels = {
    project = "${var.project_name}"
    env     = "${var.env}"
  }
  
  mysql_dump_path = "db-${var.project_name}-${local.postfix}/${var.file_remote_path}/${var.file_upload_name}"
  mysql_db_name   = "${var.app_db_name}"
  mysql_db_users  = [
    {
      name     = "terraform" 
      password = ""
      host     = "%"
    },
    {
      name     = "${var.app_db_user}" 
      password = ""
      host     = "%"
    },
  ]
}
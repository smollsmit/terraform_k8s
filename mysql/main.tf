module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "3.3.0"

  project_id    = "${local.project_id}"
  activate_apis = "${var.api_services}"

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

# ---------- Modules
module "google_mysql" {
  source        = "../modules/google_mysql"
  organization  = "${var.organization}"
  project_name  = "${var.project_name}"
  env           = "${var.env}"
  network       = "${data.google_compute_network.compute_network.self_link}"
  tier          = "db-f1-micro"
  disk_size     = "16"
  disk_type     = "PD_SSD"
  backup_enable = true
}
provider "google" {
  credentials = "${file("../credentials/${var.project_name}-${var.env}.json")}"
  project     = local.project_id
  region      = var.region
  zone        = var.zone
}

provider "google-beta" {
  credentials = "${file("../credentials/${var.project_name}-${var.env}.json")}"
  project     = local.project_id
  region      = var.region
  zone        = var.zone
}

data "google_client_config" "default" {
  provider = google
}

provider "kubernetes" {
  load_config_file  = false
}
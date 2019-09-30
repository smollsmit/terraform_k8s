provider "google" {
  credentials = "${file("../credentials.json")}"
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

provider "google-beta" {
  credentials = "${file("../credentials.json")}"
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

data "google_client_config" "default" {
  provider = google
}

provider "kubernetes" {
  load_config_file  = false
}
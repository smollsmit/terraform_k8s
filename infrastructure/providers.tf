provider "google" {
  credentials = "${file("../globals/credentials/${var.project_name}-${var.env}.json")}"
  project     = "${local.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

provider "google-beta" {
  credentials = "${file("../globals/credentials/${var.project_name}-${var.env}.json")}"
  project     = "${local.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

data "google_client_config" "default" {
  provider = "google"
}

provider "kubernetes" {
  load_config_file  = false
}

provider "helm" {
  install_tiller = true
}
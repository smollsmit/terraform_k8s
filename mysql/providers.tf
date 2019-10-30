provider "google" {
  credentials = "${file("../globals/credentials/${var.project_name}.json")}"
  project     = "${local.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

provider "google-beta" {
  credentials = "${file("../globals/credentials/${var.project_name}.json")}"
  project     = "${local.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

# ---------- Backand for tfstate files
terraform {
  backend "gcs" {
    bucket = "terraform-state-online"
    prefix = "mysql"
  }
}
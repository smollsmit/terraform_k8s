provider "google" {
  credentials = "${file("credentials.json")}"
  project     = "${var.project}"
  region      = "${var.region_name}"
  zone        = "${var.zone_name}"
}
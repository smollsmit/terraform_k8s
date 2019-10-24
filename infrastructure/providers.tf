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

# Use manual created token.
provider "cloudflare" {
  email     = "${var.cf_email}"
  api_token = "${var.cf_token}"
}
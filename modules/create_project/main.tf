resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.project_name}-${var.env}-"
}
resource "google_project" "project" {
  name                = "${var.project_name}-${var.env}"
  project_id          = "${random_id.id.hex}"
  billing_account     = "${var.billing_account}"
  auto_create_network = false
}
resource "google_project_services" "project_api" {
  project             = "${google_project.project.project_id}"

  services = [
    "compute.googleapis.com",
    "container.googleapis.com"
  ]

}
resource "google_service_account" "terraform" {
  account_id = "terraform"
  display_name = "Account for automation aim"
}
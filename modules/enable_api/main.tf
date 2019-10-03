resource "google_project_services" "project-api" {
  project             = "${google_project.project.project_id}"
  disable_on_destroy  = true

  services = [
    "compute.googleapis.com",
    "container.googleapis.com"
  ]

  lifecycle {
    prevent_destroy = true
  }

}
resource "google_folder" "folder" {
  display_name = "${var.project)-${var.env}"
  parent     = "organizations/1234567"
}

resource "google_project" "project" {
  name        = "${var.project)-${var.env}" 
  project_id  = "${var.project)-${var.env}"
  folder_id   = "${google_folder.folder.name}"
}
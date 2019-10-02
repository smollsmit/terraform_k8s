resource "google_project_service" "kubernetes-engine-api" {                                                                                                                                                 
  project = var.project
  service = "container.googleapis.com"

  lifecycle {
    prevent_destroy = true
  }

}

resource "google_project_service" "compute-engine-api" {
  project = var.project
  service = "compute.googleapis.com"
  
  lifecycle {
    prevent_destroy = true
  }

}
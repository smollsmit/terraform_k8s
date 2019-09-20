data "google_container_cluster" "k8s_cluster" {
  name        = ${var.name}
  description = ${var.description}
  project     = ${var.project}
  location    = ${var.location}
}
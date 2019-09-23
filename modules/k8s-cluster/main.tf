resource "google_container_cluster" "k8s-cluster" {
  name      = "k8s-${var.project}-${var.env}"
  location  = var.location
  initial_node_count = 1

  addons_config {
 
    kubernetes_dashboard {
      disabled = ! var.dashboard
    }
 
  }
}
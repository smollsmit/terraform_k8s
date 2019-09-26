resource "google_container_cluster" "k8s-cluster" {
  name      = "k8s-${var.project}-${var.env}"
  location  = var.location
  #network   = var.network

  initial_node_count        = 1
  remove_default_node_pool  = true

  addons_config {

    kubernetes_dashboard {
      disabled = ! var.dashboard
    }

    http_load_balancing {
      disabled = ! var.http-load-balancing
    }
  }
}

resource "google_container_node_pool" "pools" {
  name        = var.node_pools[count.index]["name"]
  location    = var.location
  cluster     = google_container_cluster.k8s-cluster.name
  count       = length(var.node_pools)
  node_count  = var.node_pools[count.index]["node_count"]

  node_config {
    preemptible  = true
    machine_type = var.node_pools[count.index]["machine_type"]
    disk_size_gb = var.node_pools[count.index]["disk_size_gb"] 
    disk_type    = var.node_pools[count.index]["disk_type"]

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
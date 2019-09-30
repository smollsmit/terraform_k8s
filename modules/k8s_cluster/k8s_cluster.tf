resource "google_container_cluster" "k8s_cluster" {
  name      = "k8s-${var.project}-${var.env}"
  location  = var.location
  
  network       = var.network
  subnetwork    = var.subnetwork

  initial_node_count        = 1
  remove_default_node_pool  = true

  addons_config {

    kubernetes_dashboard {
      disabled = ! var.dashboard
    }

    http_load_balancing {
      disabled = ! var.http_load_balancing
    }
  }

  ip_allocation_policy {
    use_ip_aliases  = true
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes = true
    master_ipv4_cidr_block = var.master_subnet
  }
}

resource "google_container_node_pool" "pools" {
  name        = var.node_pools[count.index]["name"]
  location    = var.location
  cluster     = google_container_cluster.k8s_cluster.name
  count       = length(var.node_pools)
  node_count  = var.node_pools[count.index]["node_count"]

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    machine_type = var.node_pools[count.index]["machine_type"]
    disk_size_gb = var.node_pools[count.index]["disk_size_gb"] 
    disk_type    = var.node_pools[count.index]["disk_type"]

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.env
    }
  }
}
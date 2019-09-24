resource "google_container_cluster" "k8s-cluster" {
  name                = "k8s-${var.project}-${var.env}"
  location            = var.location

  network             = var.network
  subnetwork          = var.subnetwork

  initial_node_count  = 1

  addons_config {

    kubernetes_dashboard {
      disabled = ! var.dashboard
    }

    http_load_balancing {
      disabled = ! var.http-load-balancing
    }

  }

  #private_cluster_config {
  #  enable_private_endpoint = var.disable_public_endpoint
  #  enable_private_nodes    = var.enable_private_nodes
  #  master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  #}

  #master_auth {
  #  username = var.basic_auth_username
  #  password = var.basic_auth_password

  #  client_certificate_config {
  #    issue_client_certificate = var.enable_kubernetes_dashboard
  #  }
  #}
}
# ---------- VPC
resource "google_compute_network" "vpc" {                                                                                                                                                                   
  name                    =  "${format("%s","${var.project}-${var.env}-vpc")}"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}

# ---------- Subnetwork
resource "google_compute_subnetwork" "node_subnet" {
  name          = "${format("%s","${google_compute_network.vpc.name}-node-subnet")}"
  project       = var.project_id
  ip_cidr_range = var.node_subnet
  network       = google_compute_network.vpc.name
  region        = var.region
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "${format("%s","${google_compute_network.vpc.name}-db-subnet")}"
  project       = var.project_id
  ip_cidr_range = var.db_subnet
  network       = google_compute_network.vpc.name
  region        = var.region
}

# ---------- IP Address
resource "google_compute_address" "bastion-ip-pub" {
  name = "bastion-ip-pub"
}

# ---------- Firewall's rule
resource "google_compute_firewall" "allow-web-from-all-in" {
    name    = "${var.project}-allow-web-from-all-in"
    network = google_compute_network.vpc.name
    allow {
        protocol = "tcp"
        ports    = ["80","443"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["allow-web-from-all-in"] 
}

resource "google_compute_firewall" "allow-ssh-from-all-in" {
    name    = "${var.project}-allow-ssh-from-all-in"
    network = google_compute_network.vpc.name
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["allow-ssh-from-all-in"]
}

resource "google_compute_firewall" "allow-all-out" {
    name    = "${var.project}-allow-all-out"
    network = google_compute_network.vpc.name

    allow {
        protocol = "all"
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["allow-all-out"]
}
resource "google_compute_firewall" "allow-all-from-internal-in" {
    name    = "${var.project}-allow-all-from-internal-in"
    network = google_compute_network.vpc.name
    allow {
        protocol = "icmp"
    }
    allow {
        protocol = "tcp"
        ports    = ["0-65535"]
    }
    allow {
        protocol = "udp"
        ports    = ["0-65535"]
    }
    source_ranges = [
      var.node_subnet,
      var.master_subnet
    ]
    target_tags = ["allow-all-from-internal-in"] 
}
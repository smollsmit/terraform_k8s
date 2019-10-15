# Contains of global network configurations
# ---------- VPC
resource "google_compute_network" "vpc" {                                                                                                                                                                   
  name                    =  "${format("%s","${var.project_name}-${var.env}-vpc")}"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}

# ---------- Subnetwork
resource "google_compute_subnetwork" "dmz_subnet" {
  name          = "${format("%s","${google_compute_network.vpc.name}-dmz-subnet")}"
  ip_cidr_range = "${local.dmz_subnet}"
  network       = "${google_compute_network.vpc.name}"
  region        = "${var.region}"
}
resource "google_compute_subnetwork" "node_subnet" {
  name          = "${format("%s","${google_compute_network.vpc.name}-node-subnet")}"
  ip_cidr_range = "${local.node_subnet}"
  network       = "${google_compute_network.vpc.name}"
  region        = "${var.region}"
}
resource "google_compute_subnetwork" "db_subnet" {
  name          = "${format("%s","${google_compute_network.vpc.name}-db-subnet")}"
  ip_cidr_range = "${local.db_subnet}"
  network       = "${google_compute_network.vpc.name}"
  region        = "${var.region}"
}

# ---------- Firewall's rule
# ----- Web Rules
resource "google_compute_firewall" "allow-web-from-all-in" {
    name    = "${var.project_name}-allow-web-from-all-in"
    network = "${google_compute_network.vpc.name}"
    allow {
        protocol = "tcp"
        ports    = ["80","443"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["allow-web-from-all-in"]
}
# ----- SSH Rules
resource "google_compute_firewall" "allow-ssh-from-all-in" {
    name    = "${var.project_name}-allow-ssh-from-all-in"
    network = "${google_compute_network.vpc.name}"
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["allow-ssh-from-all-in"]
}
resource "google_compute_firewall" "allow-ssh-from-trusted-in" {
    name    = "${var.project_name}-allow-ssh-from-trusted-in"
    network = "${google_compute_network.vpc.name}"
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["allow-ssh-from-trusted-in"]
}

# ----- Rules for All
resource "google_compute_firewall" "allow-all-from-internal-in" {
  name    = "${var.project_name}-allow-all-from-internal-in"
  network = "${google_compute_network.vpc.name}"
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
    "${local.dmz_subnet}",
    "${local.db_subnet}",
    "${local.node_subnet}",
    "${local.master_subnet}"
  ]
  target_tags = ["allow-all-from-internal-in"] 
}
# ----- Outgouing Rules
resource "google_compute_firewall" "allow-all-out" {
  name    = "${var.project_name}-allow-all-out"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["allow-all-out"]
}
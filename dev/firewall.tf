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
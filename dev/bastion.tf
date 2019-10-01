resource "google_compute_instance" "bastion" {                                                                                                                                                              
  name         = "bastion"
  machine_type = "f1-micro"
  project      = var.project_id
  tags         = ["allow-ssh-from-all-in","allow-all-from-internal-in"]

  metadata = {
    sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork          = google_compute_subnetwork.node_subnet.name
    network_ip          = var.bastion_ip_int

    access_config {
      nat_ip = google_compute_address.bastion-ip-pub.address
    }

  }
}
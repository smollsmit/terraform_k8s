# ---------- IP Address
resource "google_compute_address" "bastion-ip-pub" {
  name = "bastion-ip-pub"
}

# ---------- Instance
resource "google_compute_instance" "bastion" {                                                                                                                                                              
  name         = "bastion"
  machine_type = "f1-micro"
  tags         = ["allow-ssh-from-trusted-in","allow-all-from-internal-in"]

  metadata = {
    sshKeys = "${join("\n", [for user in var.users_devops : "${user}:${file("../globals/pub_keys/${user}.pub")}"])}"
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install dnsutils mc -y"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork  = "${google_compute_subnetwork.dmz_subnet.name}"
    network_ip  = "${local.bastion_ip_int}"

    access_config {
      nat_ip = "${google_compute_address.bastion-ip-pub.address}"
    }

  }
}
# ---------- Instance
resource "google_compute_instance" "compute_instance" {                                                                                                                                                              
  count         = "${length(var.node_pools)}"
  name          = "${var.node_pools[count.index]["name"]}"
  machine_type  = "${var.node_pools[count.index]["machine_type"]}"
  tags          = "${var.node_pools[count.index]["tags"]}"

  metadata  = {
    sshKeys = "${join("\n", [for user in var.ssh_users : "${user}:${file("../globals/pub_keys/${user}.pub")}"])}"
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install ${var.packages} -y"

  boot_disk {
    initialize_params {
      type  = "${var.node_pools[count.index]["disk_type"]}"
      image = "${var.vm_image}"
    }
  }

  network_interface {
    subnetwork  = "${var.node_pools[count.index]["subnetwork"]}"
    network_ip  = "${var.node_pools[count.index]["ip_int"]}"

    dynamic "access_config" {
      for_each = var.node_pools[count.index]["ip_pub_enabled"] ? [""] : []

      content {
        nat_ip = "${var.node_pools[count.index]["ip_pub_value"]}"
      }

    }
  }
}

# ---------- Create google dns record set
resource "google_dns_record_set" "dns_record_set" {
  count         = "${length(var.node_pools)}"
  name          = "${var.node_pools[count.index]["name"]}.${var.node_pools[count.index]["dns_zone_name"]}."
  type          = "A"
  ttl           = "120"

  managed_zone  = "${var.project_name}-${var.env}"
    
  rrdatas       = ["${var.node_pools[count.index]["ip_int"]}"]

  lifecycle {
    ignore_changes = []
    create_before_destroy = true
  }
} 
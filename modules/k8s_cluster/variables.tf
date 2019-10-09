variable "location" {
  default = "undefined"
}

variable "project" {
  default = "undefined"
}

variable "project_id" {
  default = "undefined"
}

variable "env" {
  default = "undefined"
}

# ---------- Networking
variable "network" {
  default = "default"
}

variable "subnetwork" {
  default = "default"
}

variable "master_subnet" {
  default = "default"
}

# ---------- Cluster configurations
variable "node_pools" {
  description = "List of maps containing node pools"

  default = [
    {
      name          = "default-node-pool"
      node_count    = "1"
      machine_type  = "n1-standard-1"
    },
  ]
}
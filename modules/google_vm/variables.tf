variable "project_name" {
  default = "undefined"
}

variable "env" {
  default = "undefined"
}

variable "packages" {
  default = "mc ncdu dnsutils"
}

variable "ssh_users" {
  default = [
    "smith",
    "test"
  ]
}

variable "node_pools" {
  description = "List of maps containing node pools"

  default = [
    {
      name          = "default"
      node_count    = "1"
      machine_type  = "f1-micro"
    },
  ]
}

variable "managed_zone" {
  default = "undefined"
}
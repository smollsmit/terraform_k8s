variable "organization" {
  type = "string"
  default = "undefined"
}
variable "project_name" {
  default = "undefined"
}

variable "env" {
  default = "undefined"
}

variable "packages" {
  default = "mc ncdu dnsutils telnet"
}

variable "ssh_users" {
  default = [
    "smith",
    "test"
  ]
}

variable "node_pools" {
  description = "List of maps containing node pools"
  default = [{}]
}

variable "vm_image" {
  default = "debian-cloud/debian-9"
}
variable "organization" {
  default = "undefined"
}
variable "project_name" {
  default = "undefined"
}
variable "env" {
  default = "undefined"
}
variable "network" {
  default = "undefined"
}

variable "backup_enable" {
  default = "true"
}

variable "tier" {
  default = "db-f1-micro"
}

variable "disk_size" {
  default = "16"
}

variable "disk_type" {
  default = "PD_SSD"
}
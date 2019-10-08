# ---------- Projects params
variable "project_id" {
  default = "undefined"
}

variable "project_name" {
  default = "undefined"
}

variable "env" {
  default = "undefined"
}

variable "region" {
  default = "europe-west3"  
}

variable "zone" {
  default = "europe-west3-a"
}

# ---------- Network

variable "master_subnet" {
  default = "undefined"
}

variable "node_subnet" {
  default = "undefined"
}

variable "db_subnet" {
  default = "undefined"
}

variable "bastion_ip_int" {
  default = "10.1.1.250"
}

# ---------- Users
variable "ssh_user" {
  default = "smith"
}
variable "ssh_pub_key_file" {
  default = "/home/smith/.ssh/id_rsa.pub"
}

variable "billing_accaunt" {
  default = "undefined"
}
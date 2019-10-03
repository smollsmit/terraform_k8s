# ---------- Projects params
variable "project_id" {
    default = ""
}

variable "project_name" {
    default = "hubber"
}

variable "env" {
    default = "dev"
}

variable "region" {
    default = "europe-west3"  
}

variable "zone" {
    default = "europe-west3-a"
}

# ---------- Network

variable "master_subnet" {
    default = "10.1.0.0/28"
}

variable "node_subnet" {
    default = "10.1.1.0/24"
}

variable "db_subnet" {
    default = "10.1.11.0/24"
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

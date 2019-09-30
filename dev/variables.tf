# ---------- Projects params
variable "project_id" {
    default = "opportunity-quohai"
}

variable "project" {
    default = "opportunity"
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

# ---------- Users
variable "ssh_user" {
    default = "s.smetanin"
}
variable "ssh_pub_key_file" {
    default = "/home/smith/.ssh/id_rsa.pub"
}
# ---------- Projects params
variable "project" {
    default = "opportunity-quohai"
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
variable "k8s-cluster-subnet" {
    default = "10.1.1.0/24"
}

variable "db-subnet" {
    default = "10.1.2.0/24"
}

# ---------- Users
variable "ssh-user" {
    default = "s.smetanin"
}
variable "ssh-pub-key-file" {
    default = "/home/smith/.ssh/id_rsa.pub"
}
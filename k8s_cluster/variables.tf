# ---------- Projects params
variable "organization" {
  type = string
  default = "undefined"
}

variable "project_id" {
  type = string
  default = "undefined"
}

variable "project_name" {
  type = string
  default = "undefined"
}

variable "env" {
  type = string
  default = "undefined"
}

variable "region" {
  type = string
  default = "europe-west3"  
}

variable "zone" {
  type = string
  default = "europe-west3-a"
}

variable "tfplan" {
  type = string
  default = "undefined"
}

variable "api_services" {
  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "oslogin.googleapis.com",
    "serviceusage.googleapis.com",
    "dns.googleapis.com",
    "storage-api.googleapis.com",
  ]
}

# ---------- Network
variable "master_subnet" {
  type = string
  default = "undefined"
}

variable "node_subnet" {
  type = string
  default = "undefined"
}

variable "db_subnet" {
  type = string
  default = "undefined"
}

variable "bastion_ip_int" {
  type = string
  default = "10.1.1.250"
}

# ---------- Users
variable "ssh_user" {
  type = string
  default = "smith"
}
variable "ssh_pub_key_file" {
  type = string
  default = "/home/smith/.ssh/id_rsa.pub"
}

variable "billing_accaunt" {
  type = string
  default = "undefined"
}

# ---------- DNS
variable "dns_name" {
  type = string
  default = "undefined" 
}
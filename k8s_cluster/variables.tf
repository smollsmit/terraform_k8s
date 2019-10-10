# ---------- Projects params
variable "organization" {
  type = "string"
  default = "undefined"
}

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

variable "tfplan" {
  default = "undefined"
}

variable "api_services" {
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
  default = "undefined"
}

variable "node_subnet" {
  default = "undefined"
}

variable "db_subnet" {
  default = "undefined"
}

variable "dmz_subnet" {
  default = "undefined"
}

variable "bastion_ip_int" {
  default = "undefined"
}

# ---------- Users
#variable "root_ssh_user" {
#  default = "undefined"
#}
#variable "root_ssh_pub_key_file" {
#  default = "undefined"
#}

variable "billing_accaunt" {
  default = "undefined"
}

variable "users_devops" {
  default = ""
}

# ---------- Cluster nodes 
variable "frontend_node_count" {
  default = "1"
}
variable "backend_node_count" {
  default = "1"
}

# ---------- DNS
variable "dns_a_records" {
  default = {
    "bastion" = "10.0.0.250"
  }
}
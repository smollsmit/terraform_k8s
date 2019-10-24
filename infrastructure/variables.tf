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

# ---------- API Enable
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
variable "public_trusted_hosts" {
  default = "undefined"
}
variable "vpc_network" {
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

# ---------- VPN
variable "vpn_shared_secret" {
  default = "undefined"
}
variable "vpn_peer_ip" {
  default = "undefined"
}
variable "vpn_remote_network" {
  default = "undefined"
}

# ---------- Users
variable "billing_accaunt" {
  default = "undefined"
}

# ---------- Cloudflare 
variable "cf_email" {
  default = "undefined"
}
variable "cf_token" {
  default = "undefined"
}
variable "cf_zone" {
  default = "undefined"
}
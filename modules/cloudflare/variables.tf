# ---------- Project
variable "project_name" {
  default = "undefined"
}
variable "env" {
  default = "undefined"
}

# ---------- Cloudflare
variable "cf_zone" {
  default = "undefined"
}
variable "cf_a_records" {
  default = "undefined"
}
variable "cf_cname_records" {
  default = "undefined"
}

# ---------- IP
variable "ingress_ip_pub" {
  default = "undefined"
}
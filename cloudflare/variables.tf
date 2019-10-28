# ---------- Projects params
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
variable "cf_a_records" {
  default = [
    {
      name    = "@"
      value   = ""
      proxied = true
    },
  ]
}

variable "cf_cname_records" {
  default = [
    {
      name  = "office.dev"
      value = ""
      proxied = true
    },
    {
      name  = "rmq.dev"
      value = ""
      proxied = true
    },
    {
      name  = "dev"
      value = ""
      proxied = true
    },
    {
      name  = "*.dev"
      value = ""
      proxied = false
    },
    {
      name  = "*.stage"
      value = ""
      proxied = false
    },
  ]
}
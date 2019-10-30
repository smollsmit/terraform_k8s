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
    "sqladmin.googleapis.com",
  ]
}

# ---------- MySQL
variable "mysql_subnet_name" {
  default = "undefined"
}
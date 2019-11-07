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
variable "location" {
  default = "europe-west3"
}

# ---------- API Enable
variable "api_services" {
  default = [
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com",
  ]
}

# ---------- Network
variable "vpc_name" {
  default = "undefined"
}

# ---------- Bucket
variable "file_local_path" {
  default = "undefined"
}
variable "file_remote_path" {
  default = "undefined"
}

variable "file_upload_name" {
  default = "undefined"
}

# ---------- MySQL
variable "app_db_name" {
  default = "undefined"
}
variable "app_db_user" {
  default = "undefined"
}
# ---------- Projects params
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

# ---------- Docker registry
variable "docker_server" {
  default = "undefined"
}

variable "docker_username" {
  default = "undefined"
}

variable "docker_password" {
  default = "undefined"
}

variable "docker_email" {
  default = "undefined"
}
variable "project_name" {
  description = "(Required) Project name. Consist of project name and environment"
  default     = "undefined"
}

variable "env" {
  description = "Environment for service"
  default     = "undefined"
}

variable "dns_zone_name" {
  description = "(Required) The fully qualified DNS name of this zone"
  default     = "undefined"
}

variable "visibility_network" {
  default = "undefined"
}
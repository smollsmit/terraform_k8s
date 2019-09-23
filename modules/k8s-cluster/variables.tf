variable "location" {
  type = string
  default = "undefined"
}
variable "project" {
  type = string
  default = "undefined"
}
variable "env" {
  type = string
  default = "undefined"
}

variable "dashboard" {
  type        = bool
  description = "Enable kubernetes dashboard addon"
  default     = false
}
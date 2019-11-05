variable "organization" {
  default = "undefined"
}
variable "project_name" {
  default = "undefined"
}
variable "env" {
  default = "undefined"
}
variable "network" {
  default = "undefined"
}

variable "tier" {
  default = "db-f1-micro"
}

variable "disk_size" {
  default = "16"
}

variable "disk_type" {
  default = "PD_SSD"
}

# ---------- Replication
variable "failover_enabled" {
  default = true
}
variable "backup_enabled" {
  default = true
}

variable "mysql_users" {
  description = "A list of users to be created in your cluster"
  default = [
    {
      name     = "terraform" 
      password = ""
      host     = "%"
    },
    {
      name     = "online" 
      password = ""
      host     = "%"
    },
  ]
}

variable "mysql_host" {
  description = "The host for the default user"
  default     = "%"
}

variable "mysql_dump_src" {
  default = "undefined"
}
variable "mysql_dump_dst" {
  default = "undefined"
}
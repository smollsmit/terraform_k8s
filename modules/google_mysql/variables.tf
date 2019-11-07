# ---------- Project
variable "network" {
  default = "undefined"
}

# ---------- Replication

variable "labels" {
  default = true
}
variable "mysql_db_users" {
  description = "A list of users to be created in your cluster"
  default = [
    {
      name     = "terraform" 
      password = ""
      host     = "%"
    },
  ]
}
variable "mysql_host" {
  description = "The host for the default user"
  default     = "%"
}
variable "mysql_db_name" {
  default     = "undefined"
}
variable "mysql_dump_path" {
  default     = "undefined"
}

# ----- Master
variable "master_instance_name" {
  default = "undefined"
}
variable "master_public_ip_enabled" {
  default = false
}
variable "master_tier" {
  default = "db-f1-micro"
}
variable "master_backup_enabled" {
  default = true
}
variable "master_backup_time" {
  default = "23:00"
}

# ----- Failover
variable "failover_enabled" {
  default = true
}
variable "failover_instance_name" {
  default = "undefined"
}
variable "failover_public_ip_enabled" {
  default = false
}
variable "failover_tier" {
  default = "db-f1-micro"
}
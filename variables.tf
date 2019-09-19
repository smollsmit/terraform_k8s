# ---------- Projects params
variable "project" {
    default = "opportunity-quohai"
}

variable "env" {
    default = "test"    
}

variable "region_name" {
    default = "europe-west3"  
}

variable "zone_name" {
    default = "europe-west3-a"
}

# ---------- Users
variable "gce_ssh_user" {
    default = "s.smetanin"
}
variable "gce_ssh_pub_key_file" {
    default = "/home/smith/.ssh/id_rsa.pub"
}

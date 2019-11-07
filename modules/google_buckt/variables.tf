# ---------- Project

# ---------- Bucket
variable "bucket_name" {
  default = "undefined"
}
variable "bucket_user_role" {
  default = "undefined"
}
variable "bucket_user_email" {
  default = "undefined"
}
variable "location" {
  default = "EU"
}
variable "labels" {
}
variable "versioning_enabled" {
  default = false
}

# ---------- Upload File
variable "file_local_path" {
  default = "undefined"
}
variable "file_remote_path" {
  default = "undefined"
}
variable "file_upload_name" {
  default = "undefined"
}
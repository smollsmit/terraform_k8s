# ---------- Create Bucket for DB Backup and grant access
resource "google_storage_bucket" "db_bucket" {
  name     = "${var.bucket_name}"
  location = "${var.location}"

  lifecycle {
    ignore_changes = []
    create_before_destroy = true
  }

  labels = "${var.labels}"

  versioning {
    enabled = "${var.versioning_enabled}"
  }

  force_destroy = true

}

resource "google_storage_bucket_iam_member" "bucket_iam_member" {
  bucket = "${google_storage_bucket.db_bucket.name}"
  role   = "${var.bucket_user_role}" 
  member = "serviceAccount:${var.bucket_user_email}"

}

# ---------- Upload DB to Bucket
resource "google_storage_bucket_object" "bucket_object" {
  name   = "${var.file_remote_path}/${var.file_upload_name}"
  source = "${var.file_local_path}/${var.file_upload_name}"
  bucket = "${google_storage_bucket.db_bucket.name}"

  depends_on = [
    "google_storage_bucket.db_bucket"
  ]

}
# ---------- IP
resource "google_compute_global_address" "lb-ip-pub" {
  name = "lb-ip-pub"
}

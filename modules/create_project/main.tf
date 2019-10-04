resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.project_name}-${var.env}-"
}

resource "google_project" "project" {
  name                = "${var.project_name}-${var.env}"
  project_id          = random_id.id.hex
  billing_account     = var.billing_account
  auto_create_network = false
}

resource "google_project_services" "project_api" {
  project   = google_project.project.project_id

  services  = [
    "compute.googleapis.com",
    "container.googleapis.com",
    #"oslogin.googleapis.com",
    #"iap.googleapis.com"
  ]

}

# ---------- Accounts and policy
resource "google_service_account" "terraform" {
  account_id    = "terraform"
  project       = google_project.project.project_id
  display_name  = "Account for automation aim"
}

data "google_iam_policy" "terraform_policy" {

  binding {
    role = "roles/owner"
    members = ["serviceAccount:${google_service_account.terraform.email}"]

  }
}

#resource "google_project_iam_policy" "policy" {
#  project     = google_project.project.project_id
#  policy_data = "${data.google_iam_policy.terraform_policy.policy_data}"
#}

#resource "google_project_iam_binding" "project" {
#  project = google_project.project.project_id
#  role    = "roles/editor"
#
#  members = [
#    "user:terraform@hubber-dev-e9e6f8be.iam.gserviceaccount.com", 
#  ]
#}
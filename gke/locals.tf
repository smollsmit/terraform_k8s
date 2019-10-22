data "external" "credentials" {
  program = ["cat", "../globals/credentials/${var.project_name}-${var.env}.json"]
}

locals {
  project_id      = "${data.external.credentials.result.project_id}"
}
module "create_project" {
  source = "../modules/create_project"
  organization    = var.organization
  env             = var.env
  billing_account = var.billing_account
  project_name    = var.project_name
}
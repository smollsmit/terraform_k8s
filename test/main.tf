module "k8s-cluster" {
  source    = "../modules/k8s-cluster"
  project   = var.project
  env       = var.env
  location  = var.region
}
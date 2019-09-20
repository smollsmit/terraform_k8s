terraform {
    required_version = ">= 0.12.8"
}

module "k8s_cluster" {
    source = "./modules/k8s_cluster"

    name        = ${var.name}
    project     = ${var.project}
    description = ${var.description}
    location    = ${var.region}
}
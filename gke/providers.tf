provider "google" {
  credentials = "${file("../globals/credentials/${var.project_name}-${var.env}.json")}"
  project     = "${local.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

provider "google-beta" {
  credentials = "${file("../globals/credentials/${var.project_name}-${var.env}.json")}"
  project     = "${local.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

data "google_client_config" "client_config" {
  provider  = "google"
}

data "google_container_cluster" "container_cluster" {
  name      = "${var.project_name}-${var.env}"
  zone      = "${var.zone}"
}


provider "kubernetes" {
  host = "https://${data.google_container_cluster.container_cluster.endpoint}"
  token = "${data.google_client_config.client_config.access_token}"
  cluster_ca_certificate = "${base64decode(data.google_container_cluster.container_cluster.master_auth.0.cluster_ca_certificate)}"

  load_config_file  = false

}

provider "helm" {
  install_tiller  = false
  service_account = "tiller"
  namespace       = "kube-system"
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.14.3"
  enable_tls      = true

  kubernetes {
    host = "https://${data.google_container_cluster.container_cluster.endpoint}"
    token = "${data.google_client_config.client_config.access_token}"
    cluster_ca_certificate = "${base64decode(data.google_container_cluster.container_cluster.master_auth.0.cluster_ca_certificate)}"
  }

}
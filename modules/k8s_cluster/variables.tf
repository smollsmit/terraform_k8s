variable "location" {
  default = "undefined"
}

variable "project" {
  default = "undefined"
}

variable "project_id" {
  default = "undefined"
}

variable "env" {
  default = "undefined"
}

# ---------- Networking
variable "network" {
  default = "default"
}

variable "subnetwork" {
  default = "default"
}

variable "master_subnet" {
  default = "default"
}

variable "node_subnet" {
  default = "default"
}

# ---------- Cluster configurations
variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool."
  default     = 0
}

variable "logging_service" {
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none"
  default     = "logging.googleapis.com"
}

variable "monitoring_service" {
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none"
  default     = "monitoring.googleapis.com"
}

variable "node_pools" {
  description = "List of maps containing node pools"

  default = [
    {
      name          = "default-node-pool"
      node_count    = "1"
      machine_type  = "n1-standard-1"
    },
  ]
}
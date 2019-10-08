variable "location" {
  type = string
  default = "undefined"
}

variable "project" {
  type = string
  default = "undefined"
}

variable "project_id" {
  default = "undefined"
}

variable "env" {
  type = string
  default = "undefined"
}

# ---------- Networking
variable "network" {
  type = string
  default = "default"
}

variable "subnetwork" {
  type = string
  default = "default"
}

variable "master_subnet" {
  type = string
  default = "default"
}

variable "node_subnet" {
  type = string
  default = "default"
}

# ---------- Addons
variable "dashboard" {
  type        = bool
  description = "Enable kubernetes dashboard addon"
  default     = false
}

variable "http_load_balancing" {
  type        = bool
  description = "Enable httpload balancer addon"
  default     = true
}

# ---------- Cluster configurations
variable "initial_node_count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
  default     = 0
}

variable "logging_service" {
  type        = string
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none"
  default     = "logging.googleapis.com"
}

variable "monitoring_service" {
  type        = string
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none"
  default     = "monitoring.googleapis.com"
}

variable "node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pools"

  default = [
    {
      name          = "default-node-pool"
      node_count    = "1"
      machine_type  = "n1-standard-1"
    },
  ]
}
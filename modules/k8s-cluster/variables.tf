variable "location" {
  type = string
  default = "undefined"
}

variable "project" {
  type = string
  default = "undefined"
}

variable "env" {
  type = string
  default = "undefined"
}

# ---------- Addons
variable "dashboard" {
  type        = bool
  description = "Enable kubernetes dashboard addon"
  default     = false
}

variable "http-load-balancing" {
  type        = bool
  description = "Enable httpload balancer addon"
  default     = true
}

variable "network-policy" {
  type        = bool
  description = "Enable network policy addon"
  default     = false
}

variable "network-policy-provider" {
  type        = string
  description = "The network policy provider."
  default     = "CALICO"
}

# ---------- Networking
variable "network" {
  type = string
  default = ""
}

variable "subnetwork" {
  type = string
  default = ""
}

# ---------- Cluster configurations
variable "initial-node-count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
  default     = 0
}

variable "logging-service" {
  type        = string
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none"
  default     = "logging.googleapis.com"
}

variable "monitoring-service" {
  type        = string
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none"
  default     = "monitoring.googleapis.com"
}
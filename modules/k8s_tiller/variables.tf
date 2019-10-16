# ---------- Namespace vars
variable "namespace_name" {
  description = "Name of the namespace to be created"
}

variable "namespace_labels" {
  description = "Map of string key value pairs that can be used to organize and categorize the namespace and roles"
  #type        = map(string)
  default     = {}
}

variable "namespace_annotations" {
  description = "Map of string key default pairs that can be used to store arbitrary metadata on the namespace and roles"
  #type        = map(string)
  default     = {}
}

# ---------- Helm
variable "helm_version" {
  type        = "string"
  default     = "v2.14.3" 
}

# ---------- Tiller
variable "tiller_namespace" {
  type        = "string"
  default     = "kube-system"
  description = "The Kubernetes namespace to use to deploy Tiller."
}

variable "tiller_service_account" {
  type        = "string"
  default     = "tiller"
  description = "The Kubernetes service account to add to Tiller."
}
provider "google" {
  project     = var.project_id
  region      = var.region
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  deletion_protection = false

  initial_node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 70
  }

  remove_default_node_pool = false
}
variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "sekhar-452813"  
}

variable "region" {
  description = "The region where the resources will be created"
  type        = string
  default     = "us-west3"  // Change to a region with sufficient quota
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "my-cluster11" 
}

variable "node_count" {
  description = "The number of nodes in the Kubernetes cluster"
  type        = number
  default     = 2
}

variable "node_machine_type" {
  description = "The type of machine to use for nodes in the Kubernetes cluster"
  type        = string
  default     = "e2-standard-4"  // Adjust based on the required machine type
}

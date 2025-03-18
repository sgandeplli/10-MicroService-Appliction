variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "sekhar-452813"
}

variable "region" {
  description = "The region where the resources will be created"
  type        = string
  default     = "us-west3"  # Use region, not zone
}

variable "zone" {
  description = "The zone for the cluster"
  type        = string
  default     = "us-west3-c"  # This is the zone
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "my-cluster11"
}

variable "node_count" {
  description = "The number of nodes in the Kubernetes cluster"
  type        = number
  default     = 3
}

variable "node_machine_type" {
  description = "The type of machine to use for nodes in the Kubernetes cluster"
  type        = string
  default     = "e2-standard-4"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a GKE Cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region  # Use the region here

  deletion_protection = false
  remove_default_node_pool = true  # Ensure no default pool is created

  initial_node_count = 1  # This is required but not used
}

# Create a new Node Pool in the correct zone
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.zone  # Use zone here
  node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 70
  }
}

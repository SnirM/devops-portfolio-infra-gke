provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "portfolio_cluster" {
  name     = "portfolio-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "portfolio-node-pool"
  location = var.region
  cluster  = google_container_cluster.portfolio_cluster.name

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 30
  }

  initial_node_count = 2
}

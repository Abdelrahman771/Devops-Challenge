resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
  project = var.project_id
}


resource "google_project_iam_member" "roles-to-sa" {
  #service_account_id = google_service_account.node-SA.name
  #multiple-google-cloud-iam-roles-to-a-service-account-via-terrafor
  role =  "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.default.email}"
  project = var.project_id
}


resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.location
  network = var.VPC_NAME
  subnetwork = var.Restricted_SubNAME


  remove_default_node_pool = true
  initial_node_count       = 1
    master_auth {
    client_certificate_config {
    issue_client_certificate = false
    }
    }

    ip_allocation_policy {

    } 

private_cluster_config {
      enable_private_nodes= true
      enable_private_endpoint = true
      master_ipv4_cidr_block ="172.16.0.0/28"
    }
  
    master_authorized_networks_config {
      cidr_blocks {
        cidr_block = var.authorized_cidr_blocks
        display_name = "External Control Plane access by management subnet"
      }
    }
}



resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}




resource "google_compute_instance" "VM" {
  name         = "vinstance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = var.VPC_NAME
    subnetwork=var.Managment_SubNAME
  }
  service_account {
      scopes = ["cloud-platform"]
    }
}



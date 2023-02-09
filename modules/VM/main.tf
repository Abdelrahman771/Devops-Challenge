
resource "google_compute_instance" "VM" {
  name         = "vinstance"
  machine_type = var.machine_type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = var.image
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



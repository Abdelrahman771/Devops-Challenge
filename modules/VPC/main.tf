resource "google_compute_network" "vpc_network" {
  project                 = "abdelrahman-ahmed-iti-project"
  name                    = "gcp-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_firewall" "FW" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name
  source_ranges= [google_compute_subnetwork.management_subnet.ip_cidr_range] 
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  
}

resource "google_compute_firewall" "FWSSH" {
  name    = "test-firewallssh"
  network = google_compute_network.vpc_network.name
  source_ranges= ["0.0.0.0/0"]
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_subnetwork" "management_subnet" {
  name          = "management-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id 
}



resource "google_compute_subnetwork" "restricted_subnet" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.management_subnet.region
  network = google_compute_network.vpc_network.id
  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.management_subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
}

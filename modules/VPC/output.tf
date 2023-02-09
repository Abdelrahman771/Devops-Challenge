output "VPC_ID" {
  value=google_compute_network.vpc_network.id
}

output "Managment_SubID" {
  value=google_compute_subnetwork.management_subnet.id
}

output "Restricted_SubID" {
  value=google_compute_subnetwork.restricted_subnet.id
}

output "VPC_NAME" {
  value=google_compute_network.vpc_network.name
}

output "Managment_SubNAME" {
  value=google_compute_subnetwork.management_subnet.name
}

output "Restricted_SubNAME" {
  value=google_compute_subnetwork.restricted_subnet.name
}
output "ip_cidr_range" {
  value = google_compute_subnetwork.management_subnet.ip_cidr_range
}
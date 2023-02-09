module "VPC" {
  source = "./modules/VPC"
}

module "VM" {
  source = "./modules/VM"
  image="debian-cloud/debian-11"
  machine_type="e2-micro"
  zone="us-central1-a"
  VPC_ID=module.VPC.VPC_ID
  Managment_SubID=module.VPC.Managment_SubID
  VPC_NAME=module.VPC.VPC_NAME
  Managment_SubNAME=module.VPC.Managment_SubNAME
}
module "CLUSTER" {
  source = "./modules/CLUSTER"
  project_id="abdelrahman-ahmed-iti-project"
  location="us-central1"
  machine_type="e2-micro"
  VPC_NAME=module.VPC.VPC_NAME
  Managment_SubNAME=module.VPC.Managment_SubNAME
  Restricted_SubNAME=module.VPC.Restricted_SubNAME
  authorized_cidr_blocks=module.VPC.ip_cidr_range
}
module "GCR" {
  source = "./modules/GCR"
  project_id="abdelrahman-ahmed-iti-project"
}

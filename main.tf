module "VPC" {
  source = "./modules/VPC"
}

module "VM" {
  source = "./modules/VM"
  VPC_ID=module.VPC.VPC_ID
  Managment_SubID=module.VPC.Managment_SubID
  VPC_NAME=module.VPC.VPC_NAME
  Managment_SubNAME=module.VPC.Managment_SubNAME
}
module "CLUSTER" {
  source = "./modules/CLUSTER"
  VPC_NAME=module.VPC.VPC_NAME
  Managment_SubNAME=module.VPC.Managment_SubNAME
  Restricted_SubNAME=module.VPC.Restricted_SubNAME
  authorized_cidr_blocks=module.VPC.ip_cidr_range
}
module "GCR" {
  source = "./modules/GCR"
  project_id="abdelrahman-ahmed-iti-project"
}

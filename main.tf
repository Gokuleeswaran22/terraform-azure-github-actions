module "resource_group" {
  source = "./modules/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
  environment         = var.environment
}

module "network" {

  source = "./modules/network"

  resource_group_name = module.resource_group.resource_group_name

  location = var.location

  vnet_name = var.vnet_name

  subnet_name = var.subnet_name

  nsg_name = var.nsg_name

  address_space = ["10.0.0.0/16"]

  subnet_prefixes = ["10.0.1.0/24"]
}
module "vm" {

  source = "./modules/vm"

  for_each = var.vms

  vm_name = each.key

  vm_size = each.value.vm_size

  data_disk_size_gb = each.value.data_disk_size_gb

  location = var.location

  resource_group_name = module.resource_group.resource_group_name

  subnet_id = module.network.subnet_id

  admin_username = var.admin_username
}
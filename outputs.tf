output "resource_group_name" {
  value = module.resource_group.resource_group_name
}
output "subnet_id" {
  value = module.network.subnet_id
}

output "vnet_name" {
  value = module.network.vnet_name
}
output "vm_name" {
  value = module.vm.vm_name
}

output "public_ip" {
  value = module.vm.public_ip
}
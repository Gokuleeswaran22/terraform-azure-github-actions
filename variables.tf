variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "vm_size" {
  type = string
}
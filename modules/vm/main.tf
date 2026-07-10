resource "azurerm_public_ip" "pip" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {

  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size = var.vm_size  

  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
}

  os_disk {
  caching              = "ReadWrite"
  storage_account_type = "StandardSSD_LRS"
}
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
}
  boot_diagnostics {
  storage_account_uri = null
}
}

resource "azurerm_managed_disk" "data_disk" {

  name                 = "${var.vm_name}-disk01"

  location             = var.location

  resource_group_name  = var.resource_group_name

  storage_account_type = "StandardSSD_LRS"

  create_option = "Empty"

  disk_size_gb = 128
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {

  managed_disk_id = azurerm_managed_disk.data_disk.id

  virtual_machine_id = azurerm_linux_virtual_machine.vm.id

  lun = 0

  caching = "ReadWrite"
}
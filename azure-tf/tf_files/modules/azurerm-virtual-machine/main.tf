resource "azurerm_network_interface" "vm" {
  for_each            = var.vm_configs
  name                = each.value.if_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          =  each.value.create_public_ip ? azurerm_public_ip.public_ip[each.key].id : null

  }
}

resource "azurerm_public_ip" "public_ip" {
  #for_each            = var.vm_configs
  for_each            = { for k, v in var.vm_configs : k => v if v.create_public_ip }
  name                = "${each.value.vm_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = each.value.allocation_method

  #tags = each.value.resource_tags
}


resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.vm_configs
  name                = each.value.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  network_interface_ids = [
    azurerm_network_interface.vm[each.key].id,
  ]
  disable_password_authentication = true

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file(each.value.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
     offer = "0001-com-ubuntu-server-jammy"
     publisher = "Canonical"
     sku = "22_04-lts"
     version = "latest"
  }
tags = var.tags  # Add this line to include tags
}

output "vm_ids" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.id]
}

output "private_ip_addresses" {
  value = {
    for vm_key, vm in azurerm_linux_virtual_machine.linux_vm :
    vm_key => azurerm_network_interface.vm[vm_key].ip_configuration[0].private_ip_address
  }
}


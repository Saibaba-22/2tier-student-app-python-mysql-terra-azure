# nic card 
resource "azurerm_network_interface" "nic1" {
    name = var.nic1_name
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name

    ip_configuration {
      name = "internal"
      private_ip_address_allocation = "Dynamic" 
      subnet_id = azurerm_subnet.sub1.id
      
      # for allocating public ip to nic card 
      public_ip_address_id = azurerm_public_ip.pip1.id
    }
}
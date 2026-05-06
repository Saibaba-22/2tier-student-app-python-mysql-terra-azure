#public ip 
resource "azurerm_public_ip" "pip1" {
    name = var.pip1_name
    resource_group_name = azurerm_resource_group.rg1.name
    location = azurerm_resource_group.rg1.location
    allocation_method = "Static"
    sku                 = "Standard"

    tags = {
        environment = " production "
    }
}
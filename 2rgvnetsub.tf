# resource group
resource "azurerm_resource_group" "rg1" {
    name = var.rg1_rg1name
    location = var.rg1_rg1loc
}

# resource virtual network 
resource "azurerm_virtual_network" "vnet1" {
    name = var.vnet1_vnetname1
    location = var.vnet1_vnetloc1 
    address_space = var.vnet1_vnet1ip
    resource_group_name = azurerm_resource_group.rg1.name
    depends_on = [ azurerm_resource_group.rg1 ]
}

# subnet 
resource "azurerm_subnet" "sub1"{
    name = var.sub1_subname 
    address_prefixes = var.sub1_subip
    resource_group_name = azurerm_resource_group.rg1.name 
    virtual_network_name = azurerm_virtual_network.vnet1.name 
    depends_on = [ azurerm_virtual_network.vnet1 ]
}



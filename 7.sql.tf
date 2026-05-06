resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = var.mysqlname
  resource_group_name    = azurerm_resource_group.rg1.name
  location               = azurerm_resource_group.rg1.location
  administrator_login    = var.db_name
  administrator_password = var.db_password

  sku_name   = "B_Standard_B1ms"
  version    = "8.0.21"
  zone       = "1"
    storage {
    size_gb           = 32
    auto_grow_enabled = true
    }

  geo_redundant_backup_enabled = false
}

resource "azurerm_mysql_flexible_database" "appdb" {
  name                = var.db_user
  resource_group_name = azurerm_resource_group.rg1.name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_azure" {
  name                = "AllowAzureServices"
  resource_group_name = azurerm_resource_group.rg1.name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
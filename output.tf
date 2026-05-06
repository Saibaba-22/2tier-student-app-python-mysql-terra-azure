# EC2 PUBLIC IP
output "vm_public_ip" {
  value = azurerm_linux_virtual_machine.vm1.public_ip_addresses
}

# SQL ENDPOINT
output "mysql_server_name" {
  value = azurerm_mysql_flexible_server.mysql.name
}

output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.mysql.fqdn
}

output "database_name" {
  value = azurerm_mysql_flexible_database.appdb.name
}

# DB Name
output "administrator_login" {
  value = azurerm_mysql_flexible_server.mysql.administrator_login
}

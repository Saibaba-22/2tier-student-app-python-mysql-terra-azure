resource "azurerm_linux_virtual_machine" "vm1" {
#vm basic 
  name                = var.vm1_name
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.nic1.id]
  depends_on = [ azurerm_mysql_flexible_server.mysql ]

# VM size 
  os_disk {
    name = "myOSdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

# OS 
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

# authentication 
  computer_name  = "studentserver"
  admin_username = var.username
  disable_password_authentication = false 
  admin_password = var.password 

  connection {
      type        = "ssh"
      user        = var.username
      password    = var.password
      host        = self.public_ip_address
    }

  provisioner "remote-exec" {
    inline = [
      "set -e",
      "mkdir -p /home/SaiAzadmin/student-python",
      "mkdir -p /home/SaiAzadmin/student-python/templates",
      "sudo chown -R SaiAzadmin:SaiAzadmin /home/SaiAzadmin/student-python"
    ]
  }

  provisioner "file" {
    content = templatefile("${path.module}/index.html.tpl", {
      vm_ip = self.public_ip_address
      } 
    )
    destination = "/home/SaiAzadmin/student-python/templates/index.html"
  }

  provisioner "file" {
    source      = "./Student-python/app.py"
    destination = "/home/SaiAzadmin/student-python/app.py"
  }

  provisioner "file" {
    source      = "./Student-python/config.py"
    destination = "/home/SaiAzadmin/student-python/config.py"
  }

  provisioner "file" {
    source      = "./Student-python/requirements.txt"
    destination = "//home/SaiAzadmin/student-python/requirements.txt"
  }

# Inside execute 
  provisioner "remote-exec" {
    inline = [
      "set -e",

      # Install dependencies
      "sudo apt update -y",
      "sudo apt install -y python3 python3-pip python3-venv python3-dev build-essential pkg-config libssl-dev libffi-dev mysql-client-core-8.0",

      # Install python pip packages
      "cd /home/SaiAzadmin/student-python && python3 -m venv venv && venv/bin/pip install --upgrade pip && venv/bin/pip install -r requirements.txt",

      # Check Versions
      "venv/bin/pip list | grep -E 'Flask|SQLAlchemy|PyMySQL|gunicorn|cryptography'",

      #1. EXPORT VARIABLE PROFILE (LOGIN SHELL SUPPORT)
      "echo 'export DB_HOST=${azurerm_mysql_flexible_server.mysql.fqdn}' | sudo tee -a /etc/profile",
      "echo 'export DB_PORT=3306' | sudo tee -a /etc/profile",
      "echo 'export DB_NAME=${var.db_name}' | sudo tee -a /etc/profile",
      "echo 'export DB_USER=${var.db_user}' | sudo tee -a /etc/profile",
      "echo 'export DB_PASSWORD=${var.db_password}' | sudo tee -a /etc/profile",

      # 2. EXPORT VARIABLE IN SYSTEM-WIDE 
      "echo 'DB_HOST=${azurerm_mysql_flexible_server.mysql.fqdn}' | sudo tee -a /etc/environment",
      "echo 'DB_PORT=3306' | sudo tee -a /etc/environment",
      "echo 'DB_NAME=${var.db_name}' | sudo tee -a /etc/environment",
      "echo 'DB_USER=${var.db_user}' | sudo tee -a /etc/environment",
      "echo 'DB_PASSWORD=${var.db_password}' | sudo tee -a /etc/environment",

      #3. EXPORT VARIABLE IN .ENV FILE (FOR PYTHON APP ONLY)
      "echo 'DB_HOST=${azurerm_mysql_flexible_server.mysql.fqdn}' > /home/SaiAzadmin/student-python/.env",
      "echo 'DB_PORT=3306' >> /home/SaiAzadmin/student-python/.env",
      "echo 'DB_NAME=${var.db_name}' >> /home/SaiAzadmin/student-python/.env",
      "echo 'DB_USER=${var.db_user}' >> /home/SaiAzadmin/student-python/.env",
      "echo 'DB_PASSWORD=${var.db_password}' >> /home/SaiAzadmin/student-python/.env",

      "cd /home/SaiAzadmin/student-python && touch app.log && echo \"===== APP START $(date) =====\" >> app.log && echo \"===== APP START $(date) =====\" >> app.log && DB_HOST=${azurerm_mysql_flexible_server.mysql.fqdn} DB_PORT=3306 DB_NAME=${var.db_name} DB_USER=${var.db_user} DB_PASSWORD=${var.db_password} nohup /home/SaiAzadmin/student-python/venv/bin/python3 /home/SaiAzadmin/student-python/app.py >> app.log 2>&1 &",
      "sleep 5",
      "cat /home/SaiAzadmin/student-python/app.log || true",
      "ps -ef | grep '[a]pp.py' || true"
      ]
    }
}

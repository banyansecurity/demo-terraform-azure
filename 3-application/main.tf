terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
    features {}
}

resource "azurerm_network_interface" "_" {
  name                = "${var.name_prefix}-nic-app"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

locals {
  init_script = <<INIT_SCRIPT
#!/bin/bash
sudo apt update -y
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
export INSTANCE_ID="${var.name_prefix}"
export PRIVATE_IP="$(hostname -i | awk '{print $1}')"
docker run -e INSTANCE_ID=$INSTANCE_ID -e PRIVATE_IP=$PRIVATE_IP -p 80:80 gcr.io/banyan-pub/demo-site
sleep 10
INIT_SCRIPT
}

resource "azurerm_linux_virtual_machine" "_" {
  name                = "${var.name_prefix}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1ls"
  admin_username      = "adminuser"
  custom_data         = base64encode(local.init_script)

  network_interface_ids = [
    azurerm_network_interface._.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(var.ssh_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    env = "${var.name_prefix}"
  }   
}

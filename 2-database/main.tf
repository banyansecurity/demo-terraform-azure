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

# Managed DB with Private IP
# https://github.com/hashicorp/terraform-provider-azurerm/blob/main/examples/private-endpoint/postgresql/main.tf
#

resource "azurerm_mysql_server" "_" {
  name                = "${var.name_prefix}-db"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = "banyan"
  administrator_login_password = "insecure123!@#"

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = false
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"

  tags = {
    env = "${var.name_prefix}"
  }  
}

resource "azurerm_private_endpoint" "_" {
  name                = "${var.name_prefix}-pvt-ep"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name_prefix}-ep-db"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mysql_server._.id
    subresource_names              = ["mysqlServer"]
  }
}
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

resource "azurerm_mysql_server" "_" {
  name                = "${var.name_prefix}-db"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = "banyan"
  administrator_login_password = "insecure123!@#"

  sku_name   = "B_Gen5_2"
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

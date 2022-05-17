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

resource "azurerm_resource_group" "_" {
  name     = var.resource_group_name
  location = var.location
  
  tags = {
    env = "${var.name_prefix}"
  }  
}

resource "azurerm_virtual_network" "_" {
  name                = "${var.name_prefix}-vnet"
  resource_group_name = azurerm_resource_group._.name
  location            = azurerm_resource_group._.location
  address_space       = [var.cidr_vnet]

  tags = {
    env = "${var.name_prefix}"
  }
}

resource "azurerm_subnet" "_" {
  name                 = "${var.name_prefix}-subnet"
  resource_group_name  = azurerm_resource_group._.name
  virtual_network_name = azurerm_virtual_network._.name
  address_prefixes     = ["${var.cidr_subnet}"]
}

resource "azurerm_public_ip" "_" {
  name                = "${var.name_prefix}-nat-ip"
  location            = azurerm_resource_group._.location
  resource_group_name = azurerm_resource_group._.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
  tags = {
    env = "${var.name_prefix}"
  }  
}

resource "azurerm_nat_gateway" "_" {
  name                    = "${var.name_prefix}-nat"
  location                = azurerm_resource_group._.location
  resource_group_name     = azurerm_resource_group._.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
  tags = {
    env = "${var.name_prefix}"
  }
}

resource "azurerm_nat_gateway_public_ip_association" "_" {
  nat_gateway_id       = azurerm_nat_gateway._.id
  public_ip_address_id = azurerm_public_ip._.id
}

resource "azurerm_subnet_nat_gateway_association" "_" {
  nat_gateway_id = azurerm_nat_gateway._.id
  subnet_id      = azurerm_subnet._.id
}


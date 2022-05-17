module "aws_connector" {
  source                 = "banyansecurity/banyan-connector/azure"
  version                = "0.0.1"
  
  name_prefix            = var.name_prefix
  location               = var.location  
  resource_group_name    = var.resource_group_name
  subnet_id              = var.subnet_id
  ssh_key_path           = var.ssh_key_path
  banyan_host            = var.banyan_host
  banyan_api_key         = var.banyan_api_key
  connector_name         = var.connector_name
}

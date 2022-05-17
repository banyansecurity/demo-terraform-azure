locals {
  connector_name = "${local.name_prefix}-conn"
  resource_group_name = "${local.name_prefix}-resg"
}

module "network" {
  source = "./1-network"
  name_prefix = local.name_prefix
  location = local.location
  resource_group_name = local.resource_group_name
}

module "database" {
  source = "./2-database"
  name_prefix = local.name_prefix
  location = local.location
  resource_group_name = local.resource_group_name
  subnet_id = module.network.subnet_id
}

module "application" {
  source = "./3-application"
  name_prefix = local.name_prefix
  location = local.location
  resource_group_name = local.resource_group_name
  subnet_id = module.network.subnet_id
  ssh_key_path = local.ssh_key_path
}

module "banyan-connector" {
  source = "./4-banyan-connector"
  name_prefix = local.name_prefix  
  location = local.location
  resource_group_name = local.resource_group_name
  subnet_id = module.network.subnet_id
  ssh_key_path = local.ssh_key_path
  banyan_host = local.banyan_host
  banyan_api_key = local.banyan_api_key
  connector_name = local.connector_name
}

module "banyan-policies" {
  source = "./5-banyan-policies"
  name_prefix = local.name_prefix  
  banyan_host = local.banyan_host
  banyan_api_key = local.banyan_api_key
}

module "banyan-services" {
  source = "./6-banyan-services"
  name_prefix = local.name_prefix  
  banyan_host = local.banyan_host
  banyan_api_key = local.banyan_api_key
  banyan_org = local.banyan_org
  connector_name = local.connector_name
  web_policy_id = module.banyan-policies.web_policy_id
  infra_policy_id = module.banyan-policies.infra_policy_id
  database_address = module.database.address
  database_port = module.database.port
  application_address = module.application.address
}
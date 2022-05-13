module "network" {
  source = "./1-network"
  name_prefix = local.name_prefix
  location = local.location
}

module "database" {
  source = "./2-database"
  name_prefix = local.name_prefix
  location = local.location
  resource_group_name = module.network.resource_group_name
}

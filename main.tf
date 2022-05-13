module "network" {
  source = "./1-network"
  name_prefix = local.name_prefix
  location = local.location
}
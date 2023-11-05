module "network" {
  source = "./modules/network"
}

module "ecs" {
  source = "./modules/ecs"

  aws_subnets = {
    subnet1 = module.network.aws_subnets.subnet1
    subnet2 = module.network.aws_subnets.subnet2
    subnet3 = module.network.aws_subnets.subnet3
  }
}
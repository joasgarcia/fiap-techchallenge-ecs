module "network" {
  source = "./modules/network"

  vpc_id = var.vpc_id
}

module "ecr_order_service" {
  source = "./modules/ecr"
  repository_name = var.order_service_settings.ecr_repository_name
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id = var.vpc_id

  aws_account_id = var.aws_account_id
  aws_account_region = var.aws_account_region

  ecr_repository_name = var.order_service_settings.ecr_repository_name

  aws_subnets = {
    subnet1 = module.network.aws_subnets.subnet1
    subnet2 = module.network.aws_subnets.subnet2
    subnet3 = module.network.aws_subnets.subnet3
  }

  app_environments_vars = var.order_service_settings.env_vars
}
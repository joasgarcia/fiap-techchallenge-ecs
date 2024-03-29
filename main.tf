module "network" {
  source = "./modules/network"

  vpc_id = var.vpc_id
}

module "ecr_order_service" {
  source = "./modules/ecr"
  repository_name = var.order_service_settings.ecr_repository_name
}

module "ecs_order_service" {
  source = "./modules/ecs"

  artifacts_prefix = var.order_service_settings.artifact_prefix
  vpc_id = var.vpc_id
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn

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


module "ecr_payment_service" {
  source = "./modules/ecr"
  repository_name = var.payment_service_settings.ecr_repository_name
}

module "ecs_payment_service" {
  source = "./modules/ecs"

  artifacts_prefix = var.payment_service_settings.artifact_prefix
  vpc_id = var.vpc_id
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn

  aws_account_id = var.aws_account_id
  aws_account_region = var.aws_account_region

  ecr_repository_name = var.payment_service_settings.ecr_repository_name

  aws_subnets = {
    subnet1 = module.network.aws_subnets.subnet1
    subnet2 = module.network.aws_subnets.subnet2
    subnet3 = module.network.aws_subnets.subnet3
  }

  app_environments_vars = null
}

module "ecr_production_service" {
  source = "./modules/ecr"
  repository_name = var.production_service_settings.ecr_repository_name
}

module "ecs_production_service" {
  source = "./modules/ecs"

  artifacts_prefix = var.production_service_settings.artifact_prefix
  vpc_id = var.vpc_id
  ecs_task_execution_role_arn = var.ecs_task_execution_role_arn

  aws_account_id = var.aws_account_id
  aws_account_region = var.aws_account_region

  ecr_repository_name = var.production_service_settings.ecr_repository_name

  aws_subnets = {
    subnet1 = module.network.aws_subnets.subnet1
    subnet2 = module.network.aws_subnets.subnet2
    subnet3 = module.network.aws_subnets.subnet3
  }

  app_environments_vars = var.production_service_settings.env_vars
}
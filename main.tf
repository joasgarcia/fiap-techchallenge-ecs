module "network" {
  source = "./modules/network"
}

module "ecr_order_service" {
  source = "./modules/ecr"
  repository_name = var.order_service_settings.ecr_repository_name
}

module "ecs" {
  source = "./modules/ecs"

  aws_account_id = var.aws_account_id
  aws_account_region = var.aws_account_region

  ecr_repository_name = var.order_service_settings.ecr_repository_name

  aws_subnets = {
    subnet1 = module.network.aws_subnets.subnet1
    subnet2 = module.network.aws_subnets.subnet2
    subnet3 = module.network.aws_subnets.subnet3
  }

  app_environments_vars = [
    {
      "name"  = "DB_URL",
      "value" = var.order_service_settings.jdbc_url
    },
    {
      "name"  = "DB_USERNAME",
      "value" = "username"
    },
    {
      "name"  = "DB_PASSWORD",
      "value" = "password"
    },
    {
      "name"  = "PAYMENT_BASE_URL",
      "value" = "https://www.google.com/"
    },
    {
      "name"  = "PRODUCTION_BASE_URL",
      "value" = "https://www.google.com/"
    },
  ]
}
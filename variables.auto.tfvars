order_service_settings = {
  ecr_repository_name = "restaurant-app/pedido"
  artifact_prefix = "order-service"
  env_vars = [
    {
      "name"  = "DB_URL",
      "value" = "jdbc:mysql://fiap-techchallenge-db.c76skywwetbx.us-east-1.rds.amazonaws.com/fiaptechchallenge"
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
      "value" = "https://www.google.com/10"
    },
    {
      "name"  = "PRODUCTION_BASE_URL",
      "value" = "https://www.google.com/"
    }
  ]
}

payment_service_settings = {
  ecr_repository_name = "restaurant-app/pagamento"
  artifact_prefix = "payment-service"
}

production_service_settings = {
  ecr_repository_name = "restaurant-app/producao"
  artifact_prefix = "production-service"
  env_vars = [
    {
      "name"  = "DB_URL",
      "value" = "jdbc:mysql://fiap-techchallenge-db.c76skywwetbx.us-east-1.rds.amazonaws.com/fiaptechchallenge"
    },
    {
      "name"  = "DB_USERNAME",
      "value" = "username"
    },
    {
      "name"  = "DB_PASSWORD",
      "value" = "password"
    }
  ]
}

aws_account_id = "372103585771"
aws_account_region = "us-east-1"
vpc_id = "vpc-03df0ff4f1685cf1a"
ecs_task_execution_role_arn = "arn:aws:iam::372103585771:role/LabRole"
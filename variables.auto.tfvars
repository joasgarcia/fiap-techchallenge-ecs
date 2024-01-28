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

aws_account_id = "372103585771"
aws_account_region = "us-east-1"
vpc_id = "vpc-03df0ff4f1685cf1a"
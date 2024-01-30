variable "order_service_settings" {
  type = object({
    ecr_repository_name = string
    artifact_prefix = string
    env_vars = list(map(string))
  })
}

variable "payment_service_settings" {
  type = object({
    ecr_repository_name = string
    artifact_prefix = string
  })
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type = string
}

variable "aws_account_region" {
  description = "AWS Account Region"
  type = string
}

variable "vpc_id" {
  description = "ID da VPC a ser utilizada em toda a infraestrutura"
  type = string
}

variable "ecs_task_execution_role_arn" {
  description = "ARN da role para executar o ECS task"
  type = string
}

variable "aws_subnets" {
  type = object({
    subnet1 = string
    subnet2 = string
    subnet3 = string
  })
}

variable "app_environments_vars" {
  type        = list(map(string))
  description = "environment variable needed by the application"
  nullable = true
}

variable "aws_account_id" {
  type = string
}

variable "aws_account_region" {
  type = string
}

variable "ecr_repository_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ecs_task_execution_role_arn" {
  description = "ARN da role para executar o ECS task"
  type = string
}

variable "artifacts_prefix" {
  type = string
}


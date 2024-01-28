variable "order_service_settings" {
  type = object({
    ecr_repository_name = string
    artifact_prefix = string
    env_vars = list(map(string))
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
variable "order_service_settings" {
  type = object({
    jdbc_url = string
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
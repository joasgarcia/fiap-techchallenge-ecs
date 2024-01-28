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
variable "aws_subnets" {
  type = object({
    subnet1 = string
    subnet2 = string
    subnet3 = string
  })
}

variable "vpc_id" {
  type = string
}

variable "artifacts_prefix" {
  type = string
}
variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-east-1"
}

variable "project" {
  default = "gt-site"
}

variable "environment" {
  default = "testing"
}

variable "aws_ecs_ami" {
  # ECS-optimized AMI for us-east-1.
  default = "ami-b2df2ca4"
}

variable "ecs_instance_profile" {
  default = "arn:aws:iam::896538046175:instance-profile/terraform-wzxkyowirnachcosiqxrriheki"
}

variable "ecs_service_role" {
  default = "arn:aws:iam::896538046175:role/ecs_service_role"
}

variable "subnet_id" {
  default     = "subnet-c5fefdb1"
  type        = "string"
  description = "Subnet ID shared by EMR and ECS"
}

variable "ec2_key" {
  default = "geotrellis-site"
  type    = "string"
}

variable "desired_instance_count" {
  default     = 1
  description = "Number benchmark instances to provision"
}

variable "ec2_instance_type" {
  default = "t2.large"
}

variable "minimum_healthy_percent" {
  default = "100"
}

variable "maximum_healthy_percent" {
  default = "200"
}

variable "ssl_certificate_arn" {}

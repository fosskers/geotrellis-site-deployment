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

variable "aws_ecs_for_ec2_service_role_policy_arn" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

variable "aws_ecs_service_role_policy_arn" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

variable "aws_cloudwatch_logs_policy_arn" {
  default = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

variable "gt_vpc" {
  default = "vpc-617f9604"
}

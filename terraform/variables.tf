variable "project" {
  default = "GeoTrellis Website"
}

variable "environment" {
  default = "Staging"
}

variable "aws_elastic_load_balancing_account_id_arn" {
  default = "arn:aws:iam::127311923021:root"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_ecs_ami" {
  default = "ami-b2df2ca4"
}

variable "aws_key_name" {
  default = "geotrellis-site"
  type    = "string"
}

variable "public_subnet_ids" {
  default = [
    "subnet-0b1b374d",
    "subnet-2ec98506",
  ]

  type        = "list"
  description = "Public subnets for the ALB"
}

variable "private_subnet_ids" {
  default = [
    "subnet-7d2ba926",
    "subnet-f2f078df",
  ]

  type        = "list"
  description = "Private subnets for the ASG"
}

variable "container_instance_asg_desired_capacity" {
  default = 2
}

variable "container_instance_asg_min_size" {
  default = 2
}

variable "container_instance_asg_max_size" {
  default = 2
}

variable "container_instance_type" {
  default = "t2.large"
}

variable "container_instance_asg_scale_up_cooldown_seconds" {
  default = "90"
}

variable "container_instance_asg_scale_down_cooldown_seconds" {
  default = "900"
}

variable "container_instance_asg_high_cpu_evaluation_periods" {
  default = "1"
}

variable "container_instance_asg_high_cpu_period_seconds" {
  default = "60"
}

variable "container_instance_asg_high_cpu_threshold_percent" {
  default = "75"
}

variable "container_instance_asg_low_cpu_evaluation_periods" {
  default = "5"
}

variable "container_instance_asg_low_cpu_period_seconds" {
  default = "60"
}

variable "container_instance_asg_low_cpu_threshold_percent" {
  default = "50"
}

variable "container_instance_asg_high_memory_evaluation_periods" {
  default = "1"
}

variable "container_instance_asg_high_memory_period_seconds" {
  default = "60"
}

variable "container_instance_asg_high_memory_threshold_percent" {
  default = "75"
}

variable "container_instance_asg_low_memory_evaluation_periods" {
  default = "5"
}

variable "container_instance_asg_low_memory_period_seconds" {
  default = "60"
}

variable "container_instance_asg_low_memory_threshold_percent" {
  default = "50"
}

variable "website_https_ecs_deployment_min_percent" {
  default = "100"
}

variable "website_https_ecs_deployment_max_percent" {
  default = "200"
}

variable "website_https_ecs_desired_count" {
  default = 1
}

variable "ssl_certificate_arn" {
  default = "arn:aws:acm:us-east-1:896538046175:certificate/a416c2af-00dd-4afd-8c71-dd32edefa839"
}

variable "aws_ecs_service_role_policy_arn" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

variable "aws_cloudwatch_logs_policy_arn" {
  default = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

variable "vpc_id" {
  default = "vpc-617f9604"
}

variable "cdn_price_class" {
  default = "PriceClass_100"
}

variable "r53_hosted_zone_id" {
  default = "ZIM2DOAEE0E8U"
}

variable "r53_hosted_zone_name" {
  default = "geotrellis.io"
}

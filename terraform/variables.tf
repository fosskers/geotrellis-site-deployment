variable "project" {
  default = "GeoTrellis Website"
}

variable "environment" {
  default = "Staging"
}

variable "aws_ecs_ami" {
  default = "ami-b2df2ca4"
}

variable "aws_key_name" {
  default = "geotrellis-site"
  type    = "string"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_elastic_load_balancing_account_id_arn" {
  default = "arn:aws:iam::127311923021:root"
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

variable "vpc_id" {
  default = "vpc-617f9604"
}

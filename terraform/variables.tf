variable "project" {
  default = "GeoTrellis Website"
}

variable "environment" {
  default = "Production"
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

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_external_access_cidr_block" {
  default = "0.0.0.0/0"
}

variable "vpc_private_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnet_cidr_blocks" {
  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "vpc_availibility_zones" {
  default = ["us-east-1a", "us-east-1c"]
}

variable "bastion_ami" {
  default = "ami-f5f41398"
}

variable "vpc_bastion_instance_type" {
  default = "t2.micro"
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

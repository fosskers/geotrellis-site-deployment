output "vpc_id" {
  value = "${module.vpc.id}"
}

output "logs_bucket_id" {
  value = "${aws_s3_bucket.logs.id}"
}

output "public_hosted_zone_id" {
  value = "${aws_route53_zone.external.id}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "container_instance_name" {
  value = "${module.container_service_cluster.name}"
}

output "container_instance_security_group_id" {
  value = "${module.container_service_cluster.container_instance_security_group_id}"
}

output "container_instance_ecs_for_ec2_service_role_name" {
  value = "${module.container_service_cluster.container_instance_ecs_for_ec2_service_role_name}"
}

output "ecs_service_role_name" {
  value = "${module.container_service_cluster.ecs_service_role_name}"
}

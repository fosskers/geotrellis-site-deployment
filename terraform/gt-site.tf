provider "aws" {
  profile = "${var.profile}" # Assumes you have valid AWS credentials.
  region  = "${var.region}"
}

# --- ECS RESOURCES --- #

resource "aws_ecs_cluster" "gt-site-cluster" {
  name = "gt-site-cluster"

  lifecycle {
    create_before_destroy = true
  }
}

# `containers.json` is analogous to `docker-compose.yml`.
# All the container settings are there.
resource "aws_ecs_task_definition" "gt-site-cluster-task" {
  family                = "gt-site-cluster"
  container_definitions = "${file("containers.json")}"
}

resource "aws_ecs_service" "gt-site-cluster-service" {
  name                               = "gt-site-cluster"
  cluster                            = "${aws_ecs_cluster.gt-site-cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.gt-site-cluster-task.family}:${aws_ecs_task_definition.gt-site-cluster-task.revision}"
  desired_count                      = "${var.desired_instance_count}"
  iam_role                           = "${var.ecs_service_role}"
  deployment_minimum_healthy_percent = "0"
  deployment_maximum_percent         = "100"

  load_balancer {
    elb_name       = "${aws_elb.gt-site-elb.name}"
    container_name = "gtsite-nginx"
    container_port = 8080
  }
}

# A load balancer is necessary to launch the EC2 manager instance properly.
resource "aws_elb" "gt-site-elb" {
  subnets = ["${var.subnet_id}"]

  listener {
    lb_port           = 80
    lb_protocol       = "HTTP"
    instance_port     = 8080   # The port that the nginx container is listening on.
    instance_protocol = "HTTP"
  }

  cross_zone_load_balancing = false
  idle_timeout              = 3600

  tags {
    Name = "gt-site-cluster elb"
  }
}

resource "aws_launch_configuration" "ecs" {
  name                 = "ECS ${aws_ecs_cluster.gt-site-cluster.name}"
  image_id             = "${var.aws_ecs_ami}"
  instance_type        = "${var.ec2_instance_type}"
  iam_instance_profile = "${var.ecs_instance_profile}"

  key_name                    = "${var.ec2_key}"
  associate_public_ip_address = true
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${aws_ecs_cluster.gt-site-cluster.name}' > /etc/ecs/ecs.config"
}

resource "aws_autoscaling_group" "ecs" {
  lifecycle {
    create_before_destroy = true
  }

  # Explicitly linking ASG and launch configuration by name
  # to force replacement on launch configuration changes.
  name = "${aws_launch_configuration.ecs.name}"

  launch_configuration      = "${aws_launch_configuration.ecs.name}"
  health_check_grace_period = 600
  health_check_type         = "EC2"
  desired_capacity          = "${var.desired_instance_count}"
  min_size                  = "${var.desired_instance_count}"
  max_size                  = "${var.desired_instance_count}"
  vpc_zone_identifier       = ["${var.subnet_id}"]

  tag {
    key                 = "Name"
    value               = "ECS ${aws_ecs_cluster.gt-site-cluster.name}"
    propagate_at_launch = true
  }
}

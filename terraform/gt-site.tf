provider "aws" {
  profile = "${var.profile}" # Assumes you have valid AWS credentials.
  region  = "${var.region}"
}

# --- ECS RESOURCES --- #

resource "aws_ecs_cluster" "gt_site_cluster" {
  name = "gtsite-${var.environment}"
}

# `containers.json` is analogous to `docker-compose.yml`.
# All the container settings are there.
resource "aws_ecs_task_definition" "gt_site_cluster_task" {
  family                = "gt-site-cluster"
  container_definitions = "${file("containers.json")}"
}

resource "aws_ecs_service" "gt_site_cluster_service" {
  name                               = "gtsite-${var.environment}"
  cluster                            = "${aws_ecs_cluster.gt_site_cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.gt_site_cluster_task.family}:${aws_ecs_task_definition.gt_site_cluster_task.revision}"
  desired_count                      = "${var.desired_instance_count}"
  iam_role                           = "${var.ecs_service_role}"
  deployment_minimum_healthy_percent = "${var.minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.maximum_healthy_percent}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.gt_site_https.id}"
    container_name   = "gtsite-nginx"
    container_port   = 8080
  }
}

# --- LOAD BALANCING --- #

# A Load Balancer, the true entrance point to the site/demo servers.
resource "aws_alb" "gt_site_alb" {
  subnets = ["${var.subnet_id}"]
  name    = "alb-gtsite-${var.environment}"

  tags {
    Name        = "alb-gtsite-${var.environment}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_target_group" "gt_site_https" {
  name = "albtg-gtsite-${var.environment}"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    timeout             = "3"
    path                = "/healthcheck/"
    unhealthy_threshold = "2"
  }

  port     = "443"
  protocol = "HTTP"

  # vpc_id = "${module.vpc.id}"

  tags {
    Name        = "albtg-gtsite-${var.environment}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "gt_site_https" {
  load_balancer_arn = "${aws_alb.gt_site_alb.id}"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "${var.ssl_certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.gt_site_https.id}"
    type             = "forward"
  }
}

# --- LAUNCH CONFIG --- #

resource "aws_launch_configuration" "ecs" {
  name                 = "ECS ${aws_ecs_cluster.gt_site_cluster.name}"
  image_id             = "${var.aws_ecs_ami}"
  instance_type        = "${var.ec2_instance_type}"
  iam_instance_profile = "${var.ecs_instance_profile}"

  key_name                    = "${var.ec2_key}"
  associate_public_ip_address = false
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${aws_ecs_cluster.gt_site_cluster.name}' > /etc/ecs/ecs.config"

  #  security_groups = ["${aws_security_group.container_instance.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs" {
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

  enabled_metrics = [
    "GroupMinSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  tag {
    key                 = "Name"
    value               = "ECS ${aws_ecs_cluster.gt_site_cluster.name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "${var.project}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}

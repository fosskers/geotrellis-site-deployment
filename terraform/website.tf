#
# Security group resources
#
resource "aws_security_group" "website_alb" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "sgWebsiteLoadBalancer"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

#
# ALB resources
#
resource "aws_alb" "website" {
  security_groups = ["${aws_security_group.website_alb.id}"]
  subnets         = ["${var.public_subnet_ids}"]
  name            = "alb${var.environment}Website"

  access_logs {
    bucket = "${aws_s3_bucket.logs.id}"
    prefix = "ALB"
  }

  tags {
    Name        = "albWebsite"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_target_group" "website_https" {
  name = "tg${var.environment}Website"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  port     = "443"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  tags {
    Name        = "tg${var.environment}Website"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_listener" "website_https" {
  load_balancer_arn = "${aws_alb.website.id}"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "${var.ssl_certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.website_https.id}"
    type             = "forward"
  }
}

#
# ECS resources
#
data "template_file" "website_https_ecs_task" {
  template = "${file("task-definitions/website.json")}"

  vars {
    region      = "${var.aws_region}"
    environment = "${var.environment}"
  }
}

resource "aws_ecs_task_definition" "website_https" {
  family                = "${var.environment}Website"
  container_definitions = "${data.template_file.website_https_ecs_task.rendered}"
}

resource "aws_ecs_service" "website_https" {
  name                               = "${var.environment}Website"
  cluster                            = "${module.container_service_cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.website_https.arn}"
  desired_count                      = "${var.website_https_ecs_desired_count}"
  deployment_minimum_healthy_percent = "${var.website_https_ecs_deployment_min_percent}"
  deployment_maximum_percent         = "${var.website_https_ecs_deployment_max_percent}"
  iam_role                           = "${aws_iam_role.container_instance_ecs.name}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.website_https.id}"
    container_name   = "gtsite-nginx"
    container_port   = "8080"
  }
}

#
# CloudWatch resources
#
resource "aws_cloudwatch_log_group" "website" {
  name              = "log${var.environment}Website"
  retention_in_days = 30
}

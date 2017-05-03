#
# Website ALB security group resources
#
resource "aws_security_group_rule" "alb_website_https_ingress" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.website_alb.id}"
}

resource "aws_security_group_rule" "alb_website_container_instance_all_egress" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  security_group_id        = "${aws_security_group.website_alb.id}"
  source_security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

#
# Container instance security group resources
#
resource "aws_security_group_rule" "container_instance_http_egress" {
  type        = "egress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

resource "aws_security_group_rule" "container_instance_https_egress" {
  type        = "egress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

resource "aws_security_group_rule" "container_instance_alb_website_all_ingress" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  security_group_id        = "${module.container_service_cluster.container_instance_security_group_id}"
  source_security_group_id = "${aws_security_group.website_alb.id}"
}

resource "aws_security_group_rule" "container_instance_alb_website_all_egress" {
  type      = "egress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  security_group_id        = "${module.container_service_cluster.container_instance_security_group_id}"
  source_security_group_id = "${aws_security_group.website_alb.id}"
}

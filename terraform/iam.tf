#
# IAM resources
#
data "aws_iam_policy_document" "container_instance_ecs_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

#
# ECS IAM
#
resource "aws_iam_role" "container_instance_ecs" {
  name               = "ecs${var.environment}InstanceRole"
  assume_role_policy = "${data.aws_iam_policy_document.container_instance_ecs_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "ecs_service_role" {
  role       = "${aws_iam_role.container_instance_ecs.name}"
  policy_arn = "${var.aws_ecs_service_role_policy_arn}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs_policy_container_instance_role" {
  role       = "${module.container_service_cluster.container_instance_ecs_for_ec2_service_role}"
  policy_arn = "${var.aws_cloudwatch_logs_policy_arn}"
}

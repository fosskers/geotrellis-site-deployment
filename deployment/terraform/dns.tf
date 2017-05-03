#
# Public DNS resources
#
resource "aws_route53_record" "origin" {
  zone_id = "${var.r53_hosted_zone_id}"
  name    = "origin.${var.r53_hosted_zone_name}"
  type    = "A"

  alias {
    name                   = "${lower(aws_alb.website.dns_name)}"
    zone_id                = "${aws_alb.website.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "website" {
  zone_id = "${var.r53_hosted_zone_id}"
  name    = "beta.${var.r53_hosted_zone_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.cdn.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}

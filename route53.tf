data "aws_route53_zone" "myzone" {
  name = "${var.domain_name}."
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.myzone.id
  name = "www.${var.domain_name}"
  type = "A"
  alias {
    name = aws_s3_bucket.s3bucket.website_domain
    zone_id = aws_s3_bucket.s3bucket.hosted_zone_id
    evaluate_target_health = false
  }
}

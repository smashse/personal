resource "aws_acm_certificate" "wildcard_domain" {
  domain_name               = aws_route53_zone.zone.name
  subject_alternative_names = ["*.${aws_route53_zone.zone.name}"]
  validation_method         = "DNS"

  tags = {
    ManagedBy = "terraform"
    Changed   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }

  lifecycle {
    ignore_changes        = [tags]
    create_before_destroy = true
  }
}

resource "aws_route53_record" "wildcard_validation" {
  name    = tolist(aws_acm_certificate.wildcard_domain.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.wildcard_domain.domain_validation_options)[0].resource_record_type
  zone_id = aws_route53_zone.zone.zone_id
  records = [tolist(aws_acm_certificate.wildcard_domain.domain_validation_options)[0].resource_record_value]
  ttl     = "60"
}

resource "aws_acm_certificate_validation" "wildcard_cert" {
  certificate_arn         = aws_acm_certificate.wildcard_domain.arn
  validation_record_fqdns = [aws_route53_record.wildcard_validation.fqdn]
}

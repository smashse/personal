resource "aws_route53_zone" "zone" {
  name = "your.domain"

  lifecycle {
    prevent_destroy = true
  }
}

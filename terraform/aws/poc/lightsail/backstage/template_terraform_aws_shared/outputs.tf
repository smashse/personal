output "bucket_name" {
  value = aws_s3_bucket.tfstate_shared.bucket
}

output "zone_id" {
  value = [
    aws_route53_zone.zone.name,
    aws_route53_zone.zone.name_servers,
    aws_route53_zone.zone.zone_id
  ]
}

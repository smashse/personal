output "microk8s_control_instance_ip_address" {
  value = aws_lightsail_static_ip.microk8s_control_ip.ip_address
}

output "endpoints" {
  value = [
    aws_route53_record.ws.fqdn,
    aws_route53_record.backstage.fqdn,
    aws_route53_record.grafana.fqdn,
    aws_route53_record.prometheus.fqdn
  ]
}

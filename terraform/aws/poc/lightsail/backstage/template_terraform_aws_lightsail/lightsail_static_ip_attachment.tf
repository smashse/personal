resource "aws_lightsail_static_ip_attachment" "microk8s_control_attachment" {
  static_ip_name = aws_lightsail_static_ip.microk8s_control_ip.id
  instance_name  = aws_lightsail_instance.microk8s_control_instance.id
}

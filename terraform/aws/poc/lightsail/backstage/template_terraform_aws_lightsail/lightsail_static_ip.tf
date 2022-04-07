resource "aws_lightsail_static_ip" "microk8s_control_ip" {
  name = "microk8s-control-ip-${terraform.workspace}"
}
resource "aws_lightsail_instance" "microk8s_control_instance" {
  name              = "microk8s-control-instance-${terraform.workspace}"
  availability_zone = var.aws_zone_id[var.aws_region]
  blueprint_id      = var.aws_blueprint_id.ubuntu
  bundle_id         = var.aws_bundle_id.large
  key_pair_name     = aws_lightsail_key_pair.key_access.name
  user_data         = (data.template_file.microk8s_control_template.rendered)
  depends_on        = [aws_lightsail_key_pair.key_access]

  tags = {
    Name = "microk8s-control-instance-${terraform.workspace}"
  }
}

data "template_file" "microk8s_control_template" {
  template = file("./cloud_init/ubuntu-microk8s-control-var.sh")
  vars     = { DOMAIN = var.domain_name }
}

resource "aws_lightsail_instance_public_ports" "microk8s_control_kube" {
  instance_name = aws_lightsail_instance.microk8s_control_instance.name

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }
  port_info {
    cidrs     = ["0.0.0.0/0", ]
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }
  port_info {
    cidrs     = ["0.0.0.0/0", ]
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }
  port_info {
    cidrs     = ["0.0.0.0/0", ]
    protocol  = "tcp"
    from_port = 16443
    to_port   = 16443
  }
}


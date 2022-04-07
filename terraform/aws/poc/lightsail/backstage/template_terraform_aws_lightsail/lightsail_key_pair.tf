resource "aws_lightsail_key_pair" "key_access" {
  name       = "access-${terraform.workspace}"
  public_key = file("./access-${terraform.workspace}.pub")
}

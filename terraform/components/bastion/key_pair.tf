resource "aws_key_pair" "key_pair" {
  key_name   = var.application
  public_key = tls_private_key.keygen.public_key_openssh

  tags = {
    Name        = format("%s-bastion", var.application)
    Description = format("Key pair for creating %s resources", var.application)
  }
}

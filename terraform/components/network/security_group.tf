resource "aws_security_group" "bastion" {
  name        = format("%s-bastion", var.application)
  description = format("Allows access to the Bastion server for %s", var.application)
  vpc_id      = aws_vpc.vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = format("SSH for %s-vpc", var.application)
    from_port   = 22
    protocol    = "tcp"
    self        = "false"
    to_port     = 22
  }

  tags = {
    Name        = format("%s-bastion", var.application)
    Description = format("Security group for creating %s resources", var.application)
  }
}

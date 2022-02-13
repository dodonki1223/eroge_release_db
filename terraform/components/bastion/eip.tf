resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc      = true

  tags = {
    Name        = format("%s-bastion", var.application)
    Description = format("Elastic IP for creating %s resources", var.application)
  }
}

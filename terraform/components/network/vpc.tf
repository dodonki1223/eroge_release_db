resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.application
    Description = format("VPC for creating %s resources", var.application)
  }
}

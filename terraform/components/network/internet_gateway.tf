resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = var.application
    Description = format("IGW for creating %s resources", var.application)
  }
}

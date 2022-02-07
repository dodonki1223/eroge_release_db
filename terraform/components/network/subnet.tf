resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = format("%s-public-%d%s", var.application, count.index + 1, substr(var.availability_zones[count.index], -1, -1))
    Description = format("Public subnet for creating %s resources", var.application)
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = format("%s-private-%d%s", var.application, count.index + 1, substr(var.availability_zones[count.index], -1, -1))
    Description = format("Private subnet for creating %s resources", var.application)
  }
}

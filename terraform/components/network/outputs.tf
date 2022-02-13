output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "availability_zones" {
  value = var.availability_zones
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "security_group_ids" {
  value = {
    bastion = aws_security_group.bastion.id
  }
}

resource "aws_db_subnet_group" "private" {
  name        = format("%s-db-private", var.application)
  description = format("%s-db-private", var.application)
  subnet_ids  = data.terraform_remote_state.network.outputs.private_subnet_ids

  tags = {
    Name        = format("%s-db-private", var.application)
    Description = format("RDS subnet group for creating %s resources", var.application)
  }
}

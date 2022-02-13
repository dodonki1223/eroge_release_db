resource "aws_db_option_group" "eroge_release" {
  name                     = format("%s-postgres-11", var.application)
  option_group_description = format("%s option group for postgres 11", var.application)
  engine_name              = "postgres"
  major_engine_version     = "11"

  tags = {
    Name        = format("%s-postgres-11", var.application)
    Description = format("DB option group for creating %s resources", var.application)
  }
}

resource "aws_db_subnet_group" "private" {
  name        = format("%s-db-private", var.application)
  description = format("%s-db-private", var.application)
  subnet_ids  = data.terraform_remote_state.network.outputs.private_subnet_ids

  tags = {
    Name        = format("%s-db-private", var.application)
    Description = format("RDS subnet group for creating %s resources", var.application)
  }
}

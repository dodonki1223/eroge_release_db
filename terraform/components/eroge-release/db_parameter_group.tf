resource "aws_db_parameter_group" "eroge_release_postgres11" {
  description = format("%s-db-postgres11", var.application)
  family      = "postgres11"
  name        = format("%s-db-postgres11" , var.application)

  parameter {
    apply_method = "immediate"
    name         = "search_path"
    value        = "'$user',eroge_release_db_schema"
  }
}

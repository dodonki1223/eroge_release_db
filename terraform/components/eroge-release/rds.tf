resource "aws_db_instance" "eroge_release" {
  # データベースに関する設定（ハード
  engine                                = "postgres"
  engine_version                        = "11.12"
  instance_class                        = "db.t3.micro"
  allocated_storage                     = 20
  max_allocated_storage                 = 100
  storage_encrypted                     = true
  storage_type                          = "gp2"

  # データベースに関する設定（ソフト
  identifier                            = format("%s-db", var.application) # コンソール画面上の識別子
  port                                  = 5432
  name                                  = format("%s_db", var.application_snake_case) # 作成するデータベース名
  username                              = "rds_master"
  password                              = random_password.password.result

  # AWS に関する設定
  db_subnet_group_name                  = aws_db_subnet_group.private.name
  parameter_group_name                  = aws_db_parameter_group.eroge_release_postgres11.name
  vpc_security_group_ids                = [data.terraform_remote_state.network.outputs.security_group_ids.rds]
  multi_az                              = true
  deletion_protection                   = false
  kms_key_id                            = aws_kms_key.rds_master_key.arn
  option_group_name                     = aws_db_option_group.eroge_release.name
  copy_tags_to_snapshot                 = true

  # バックアップに関する設定
  maintenance_window                    = "sun:18:00-sun:18:30"
  backup_retention_period               = 7
  backup_window                         = "20:00-20:30"
  skip_final_snapshot                   = false
  final_snapshot_identifier             = format("%s-db", var.application)

  # ログに関する設定
  enabled_cloudwatch_logs_exports       = ["upgrade", "postgresql"]

  # モニターに関する設定
  monitoring_interval                   = 60
  monitoring_role_arn                   = format("arn:aws:iam::%s:role/rds-monitoring-role", data.aws_caller_identity.current.account_id)
  performance_insights_enabled          = true
  performance_insights_kms_key_id       = aws_kms_key.rds_master_key.arn
  performance_insights_retention_period = 7
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

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

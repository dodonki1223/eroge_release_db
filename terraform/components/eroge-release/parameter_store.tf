resource "aws_ssm_parameter" "rds_password" {
  name   = format("/%s/rds/password", var.application)
  type   = "SecureString"
  key_id = aws_kms_key.rds_master_key.arn
  value  = aws_db_instance.eroge_release.password
}

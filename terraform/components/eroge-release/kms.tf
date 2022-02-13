resource "aws_kms_key" "rds_master_key" {
  description             = format("encrypted master key for %s-%s", var.application, var.component)
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30

  tags = {
    Name        = format("%s-kms", var.application)
    Description = format("KMS for creating %s resources", var.application)
  }
}

resource "aws_kms_alias" "rds_master_key_alias" {
  name          = format("alias/%s/rds", var.application)
  target_key_id = aws_kms_key.rds_master_key.id
}

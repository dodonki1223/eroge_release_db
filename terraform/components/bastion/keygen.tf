# 参考URL
#   https://qiita.com/mAster_rAdio/items/eead779391dc825d9bb9

locals {
  public_key_file  = format("ssh_key/%s.id_rsa.pub", var.application)
  private_key_file = format("ssh_key/%s.id_rsa", var.application)
}

resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  filename = local.private_key_file
  content  = tls_private_key.keygen.private_key_pem

  provisioner "local-exec" {
    command = format("chmod 600 %s", local.private_key_file)
  }
}

resource "local_file" "public_key_openssh" {
  filename = local.public_key_file
  content  = tls_private_key.keygen.public_key_openssh

  provisioner "local-exec" {
    command = format("chmod 600 %s", local.public_key_file)
  }
}

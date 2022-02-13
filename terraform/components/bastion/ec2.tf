resource "aws_instance" "bastion" {
  ami                         = "ami-0f310fced6141e627"
  associate_public_ip_address = "true"
  instance_type               = "t2.nano"
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  vpc_security_group_ids      = [data.terraform_remote_state.network.outputs.security_group_ids.bastion]
  key_name                    = aws_key_pair.key_pair.id

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data = <<-EOF
    #!/bin/bash
    # ホスト名の変更
    # https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/set-hostname.html
    sudo hostnamectl set-hostname eroge-release-bastion
    # PostgreSQL 11のインストール
    sudo amazon-linux-extras enable postgresql11
    sudo amazon-linux-extras install -y postgresql11
    # タイムゾーンをAsia/Tokyoに変更する
    # https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/set-time.html#change_time_zone
    sudo timedatectl set-timezone Asia/Tokyo
  EOF

  tags = {
    Name        = format("%s-bastion", var.application)
    Description = format("Bastion server for creating %s resources", var.application)
  }
}

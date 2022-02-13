data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    region  = "ap-northeast-1"
    bucket  = "eroge-release-db"
    key     = "network/terraform.tfstate"
    profile = "terraform"
  }
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

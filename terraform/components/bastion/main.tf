data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    region  = "ap-northeast-1"
    bucket  = "eroge-release-db"
    key     = "network/terraform.tfstate"
    profile = "terraform"
  }
}

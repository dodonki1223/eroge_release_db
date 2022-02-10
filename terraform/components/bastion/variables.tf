# Standard Variables
variable "aws_region" {
  description = "Target AWS Region"
  type        = string
  default     = "ap-northeast-1"
}

variable "aws_profile" {
  description = "Local AWS Profile Name"
  type        = string
  default     = "terraform"
}

variable "application" {
  description = "Application Name"
  type        = string
  default     = "eroge-release"
}

variable "component" {
  description = "Bastion server resource"
  type        = string
  default     = "bastion"
}

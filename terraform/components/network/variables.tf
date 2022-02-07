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
  description = "Network resource"
  type        = string
  default     = "network"
}

# VPC Variables
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default = [
    "ap-northeast-1a",
    "ap-northeast-1c"
  ]
}

variable "public_subnet_cidrs" {
  description = "Public subnet - CIDR"
  type        = list(string)
  default = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "Private subnet - CIDR"
  type        = list(string)
  default = [
    "10.0.21.0/24",
    "10.0.22.0/24"
  ]
}

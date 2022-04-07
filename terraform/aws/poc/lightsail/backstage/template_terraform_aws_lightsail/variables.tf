variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile used for all resources"
  default     = ""
}

variable "aws_zone_id" {
  type        = map(any)
  description = "Availability zone name used for all EC2 instances"
  default = {
    "us-east-1" = "us-east-1a"
    "us-east-2" = "us-east-2a"
  }
}

variable "aws_blueprint_id" {
  type        = map(any)
  description = "OS used for Blueprint IDs"
  default = {
    "amazon"   = "amazon_linux_2"
    "centos"   = "centos_7_1901_01"
    "opensuse" = "opensuse_15_1"
    "debian"   = "debian_10"
    "ubuntu"   = "ubuntu_20_04"
  }
}

variable "aws_bundle_id" {
  type        = map(any)
  description = "Instance type used for all Bundle instances"
  default = {
    "nano"    = "nano_2_0"
    "micro"   = "micro_2_0"
    "small"   = "small_2_0"
    "medium"  = "medium_2_0"
    "large"   = "large_2_0"
    "xlarge"  = "xlarge_2_0"
    "2xlarge" = "2xlarge_2_0"
  }
}

variable "domain_name" {
  type    = string
  default = ""
}

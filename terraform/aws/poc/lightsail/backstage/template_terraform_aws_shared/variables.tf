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
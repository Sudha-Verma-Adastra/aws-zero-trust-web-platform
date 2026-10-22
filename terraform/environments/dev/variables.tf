variable "aws_region" {
  description = "AWS region for development resources"
  type        = string
  default     = "ap-south-1"
}

variable "repository_name" {
  description = "Private ECR repository name"
  type        = string
  default     = "aws-zero-trust-web-platform"
}

variable "max_image_count" {
  description = "Maximum images retained by the ECR lifecycle policy"
  type        = number
  default     = 20
}

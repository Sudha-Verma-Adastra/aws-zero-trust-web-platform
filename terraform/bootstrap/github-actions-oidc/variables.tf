
variable "aws_region" {
  description = "AWS region for the ECR repository"
  type        = string
  default     = "ap-south-1"
}

variable "aws_account_id" {
  description = "Expected AWS account ID"
  type        = string
  default     = "611346097660"
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
  default     = "Sudha-Verma-Adastra"
}

variable "github_repository" {
  description = "GitHub repository name"
  type        = string
  default     = "aws-zero-trust-web-platform"
}

variable "ecr_repository_name" {
  description = "Existing ECR repository to publish images to"
  type        = string
  default     = "aws-zero-trust-web-platform"
}

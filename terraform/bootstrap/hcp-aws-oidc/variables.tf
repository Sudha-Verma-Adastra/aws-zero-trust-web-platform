variable "aws_region" {
  description = "AWS region for project resources"
  type        = string
  default     = "ap-south-1"
}

variable "aws_account_id" {
  description = "Expected AWS account ID; used to guard against the wrong account"
  type        = string
  default     = "611346097660"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "The AWS account ID must contain exactly 12 digits."
  }
}

variable "hcp_organization" {
  description = "HCP Terraform organization name"
  type        = string
  default     = "sudha-adastra"
}

variable "hcp_project" {
  description = "HCP Terraform project name"
  type        = string
  default     = "Default Project"
}

variable "hcp_workspace" {
  description = "HCP Terraform workspace allowed to assume this role"
  type        = string
  default     = "aws-zero-trust-web-platform-dev"
}

variable "ecr_repository_name" {
  description = "ECR repository managed by the application workspace"
  type        = string
  default     = "aws-zero-trust-web-platform"
}

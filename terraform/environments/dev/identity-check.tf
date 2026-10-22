data "aws_caller_identity" "current" {}

output "verified_aws_account_id" {
  description = "AWS account used by the Terraform provider"
  value       = data.aws_caller_identity.current.account_id
}

output "verified_aws_caller_arn" {
  description = "AWS identity used by the Terraform provider"
  value       = data.aws_caller_identity.current.arn
}

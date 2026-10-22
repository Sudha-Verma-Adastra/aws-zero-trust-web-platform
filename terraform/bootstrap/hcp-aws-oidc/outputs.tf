output "aws_account_id" {
  description = "AWS account where the OIDC role was created"
  value       = data.aws_caller_identity.current.account_id
}

output "hcp_terraform_role_arn" {
  description = "Role ARN to configure in the HCP Terraform workspace"
  value       = aws_iam_role.hcp_terraform_ecr.arn
}

output "oidc_provider_arn" {
  description = "HCP Terraform OIDC provider ARN"
  value       = aws_iam_openid_connect_provider.hcp_terraform.arn
}

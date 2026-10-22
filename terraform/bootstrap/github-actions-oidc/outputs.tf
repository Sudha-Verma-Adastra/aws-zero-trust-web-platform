
output "github_actions_role_arn" {
  description = "Configure this ARN as the AWS_GITHUB_ACTIONS_ROLE_ARN GitHub repository variable"
  value       = aws_iam_role.github_actions_ecr_publish.arn
}

output "github_oidc_provider_arn" {
  description = "GitHub Actions OIDC provider ARN"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}

output "aws_account_id" {
  description = "AWS account verified by the bootstrap"
  value       = data.aws_caller_identity.current.account_id
}

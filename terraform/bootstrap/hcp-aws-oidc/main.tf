data "aws_caller_identity" "current" {}

data "tls_certificate" "hcp_terraform" {
  url = "https://app.terraform.io"
}

resource "aws_iam_openid_connect_provider" "hcp_terraform" {
  url             = "https://app.terraform.io"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = [data.tls_certificate.hcp_terraform.certificates[0].sha1_fingerprint]

}

resource "aws_iam_role" "hcp_terraform_ecr" {
  name        = "hcp-terraform-zero-trust-ecr"
  description = "Allows only the specified HCP Terraform workspace to manage the project ECR repository"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.hcp_terraform.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "app.terraform.io:aud" = "aws.workload.identity"
        }
        StringLike = {
          "app.terraform.io:sub" = "organization:${var.hcp_organization}:project:${var.hcp_project}:workspace:${var.hcp_workspace}:run_phase:*"
        }
      }
    }]
  })

  tags = {
    Component = "hcp-terraform-oidc"
  }
}

resource "aws_iam_role_policy" "ecr_management" {
  name = "manage-zero-trust-ecr-repository"
  role = aws_iam_role.hcp_terraform_ecr.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DiscoverECR"
        Effect = "Allow"
        Action = [
          "ecr:DescribeRepositories",
          "ecr:DescribeRegistry",
          "ecr:ListTagsForResource",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:BatchGetImage",
          "ecr:GetRepositoryPolicy"
        ]
        Resource = "*"
      },
      {
        Sid    = "ManageProjectRepository"
        Effect = "Allow"
        Action = [
          "ecr:CreateRepository",
          "ecr:DeleteRepository",
          "ecr:PutImageTagMutability",
          "ecr:PutImageScanningConfiguration",
          "ecr:PutLifecyclePolicy",
          "ecr:DeleteLifecyclePolicy",
          "ecr:TagResource",
          "ecr:UntagResource"
        ]
        Resource = "arn:aws:ecr:${var.aws_region}:${var.aws_account_id}:repository/${var.ecr_repository_name}"
      }
    ]
  })
}

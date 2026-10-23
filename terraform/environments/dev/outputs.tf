output "ecr_repository_name" {
  description = "ECR repository name"
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "ecr_repository_arn" {
  description = "ECR repository ARN"
  value       = module.ecr.repository_arn
}

output "vpc_id" {
  description = "ID of the Zero Trust VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR assigned to the Zero Trust VPC."
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "Public subnet IDs for the public load balancer."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs for EKS worker nodes."
  value       = module.vpc.private_subnet_ids
}

output "private_route_table_ids" {
  description = "Private route table IDs, indexed by subnet position."
  value       = module.vpc.private_route_table_ids
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "Private Kubernetes API endpoint."
  value       = module.eks.cluster_endpoint
}

output "eks_node_group_name" {
  description = "Name of the managed node group."
  value       = module.eks.node_group_name
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS worker nodes."
  value       = module.eks.node_iam_role_arn
}
output "eks_cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for the EKS cluster."
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_cluster_oidc_provider_arn" {
  description = "IAM OIDC provider ARN for EKS IRSA."
  value       = module.eks.cluster_oidc_provider_arn
}

module "ecr" {
  source = "git::https://github.com/Sudha-Verma-Adastra/terraform-aws-platform-modules.git//modules/ecr?ref=b476619812e7bdf688aedfa5b4d1f0547a70951a"

  repository_name         = var.repository_name
  image_tag_mutability    = "IMMUTABLE"
  scan_on_push            = true
  encryption_type         = "AES256"
  create_lifecycle_policy = true
  max_image_count         = var.max_image_count

  tags = {
    Component = "container-registry"
  }
}

module "vpc" {
  source = "git::https://github.com/Sudha-Verma-Adastra/terraform-aws-platform-modules.git//modules/vpc?ref=d06e9b6569a983fabad2d72c2ea130eefc364ba5"

  name                 = "aws-zero-trust-web-platform-dev"
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  # Private EKS workloads need outbound connectivity.
  enable_nat_gateway = true
  nat_gateway_mode   = "per_az"

  # Private AWS service connectivity.
  enable_s3_endpoint              = true
  enable_ecr_endpoints            = true
  enable_cloudwatch_logs_endpoint = true
  enable_sts_endpoint             = true

  endpoint_allowed_cidrs = var.private_subnet_cidrs

  tags = {
    Component = "networking"
    Project   = "zero-trust"
  }
}

module "eks" {
  source = "git::https://github.com/Sudha-Verma-Adastra/terraform-aws-platform-modules.git//modules/eks?ref=main"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  cluster_subnet_ids = module.vpc.private_subnet_ids
  node_subnet_ids    = module.vpc.private_subnet_ids

  endpoint_private_access = true
  endpoint_public_access  = false

  node_group_name = "${var.eks_cluster_name}-workers"
  instance_types  = var.eks_node_instance_types
  capacity_type   = "ON_DEMAND"

  desired_size               = var.eks_node_desired_size
  min_size                   = var.eks_node_min_size
  max_size                   = var.eks_node_max_size
  disk_size                  = 20
  create_iam_roles           = false
  existing_cluster_role_name = "eksClusterRole"
  existing_node_role_name    = "AmazonEKSNodeRole"

  tags = {
    Component = "eks"
  }
}

module "aws_load_balancer_controller_role" {
  source = "git::https://github.com/Sudha-Verma-Adastra/terraform-aws-platform-modules.git//modules/iam-role?ref=main"

  role_name  = "${var.eks_cluster_name}-aws-load-balancer-controller"
  trust_type = "oidc"

  oidc_provider_arn = module.eks.cluster_oidc_provider_arn
  oidc_issuer_url   = module.eks.cluster_oidc_issuer_url
  oidc_subject      = "system:serviceaccount:kube-system:aws-load-balancer-controller"
  oidc_audience     = "sts.amazonaws.com"

  managed_policy_arns = []
  inline_policy_json  = null

  tags = {
    Environment = "dev"
    Project     = "aws-zero-trust-web-platform"
  }
}

variable "aws_region" {
  description = "AWS region for development resources"
  type        = string
  default     = "us-east-1"
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

variable "vpc_cidr" {
  description = "CIDR range for the Zero Trust VPC."
  type        = string
  default     = "10.40.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones for public and private subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs, one per Availability Zone."
  type        = list(string)
  default     = ["10.40.0.0/20", "10.40.16.0/20"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs, one per Availability Zone."
  type        = list(string)
  default     = ["10.40.32.0/20", "10.40.48.0/20"]
}

variable "eks_cluster_name" {
  description = "Name of the development EKS cluster."
  type        = string
  default     = "aws-zero-trust-web-platform-dev"
}

variable "eks_cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.34"
}

variable "eks_node_instance_types" {
  description = "Instance types for EKS managed worker nodes."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_node_desired_size" {
  description = "Desired worker node count."
  type        = number
  default     = 2
}

variable "eks_node_min_size" {
  description = "Minimum worker node count."
  type        = number
  default     = 1
}

variable "eks_node_max_size" {
  description = "Maximum worker node count."
  type        = number
  default     = 3
}

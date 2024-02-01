################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "../modules/vpc"
  name = var.name
  region = var.region
  environment = var.environment
#   profile     = var.profile
}

################################################################################
# EKS Cluster Module
################################################################################

module "eks" {
  source = "../modules/eks"

  cluster_name = var.name
  region = var.region
  eks_version = var.eks_version
  environment = var.environment

  roles = var.eks_roles
  users = var.eks_users

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

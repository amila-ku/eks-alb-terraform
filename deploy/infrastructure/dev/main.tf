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
  rolearn = "arn:aws:iam::845614672576:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS"
  user = "AWSServiceRoleForAmazonEKS"
  environment = var.environment
#   profile     = var.profile
#   rolearn     = var.rolearn

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

################################################################################
# Variables depending on other Modules
################################################################################

variable "cluster_name" {
  description = "cluster name"
  type        = string
}

variable "environment" {
  description = "cluster environment"
  type        = string
}

variable "eks_version" {
  description = "EKS version"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}


variable "vpc_id" {
  description = "VPC ID which EKS cluster is deployed in"
  type        = string
}

variable "private_subnets" {
  description = "VPC Private Subnets which EKS cluster is deployed in"
  type        = list(any)
}


################################################################################
# Variables defined using Environment Variables
################################################################################

variable "rolearn" {
  description = "Add admin role to the aws-auth configmap"
}

variable "user" {
  description = "Add admin user to the aws-auth configmap"
}
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

variable "vpc_cidr_block" {
  description = "VPC CIDR for which EKS cluster is deployed in"
  type        = string
}


################################################################################
# Variables defined using Environment Variables
################################################################################

variable "users" {
  description = "List of role maps to add to the aws-auth configmap"
  type        = list(object({
    userarn  = string
    username  = string
  }))
  default     = []
}

variable "roles" {
  description = "List of user maps to add to the aws-auth configmap"
  type        = list(object({
    userarn  = string
    username  = string
  }))
  default     = []
}
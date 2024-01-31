################################################################################
# Variables depending on other Modules
################################################################################

variable "name" {
  description = "VPC name"
  type        = string
}

variable "environment" {
  description = "VPC environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
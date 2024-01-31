variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "name" {
  description = "resource name"
  type        = string
  default = "nitro"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "eks_version" {
  type    = string
  default = "1.29"
}

variable "owner" {
  description = "resource owner name"
  type        = string
  default = "platform"
}
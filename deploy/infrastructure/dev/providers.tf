terraform {
    required_version = ">= 1.0"

    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = ">= 4.57"
        }
        kubernetes = {
        source  = "hashicorp/kubernetes"
        version = ">= 2.10"
        }
    }

    backend "s3" {
        bucket  = "terraform-backend-store-nt"
        encrypt = true
        key     = "terraform.tfstate"
        region  = "eu-west-1"
        # dynamodb_table = "terraform-state-lock-dynamo" - uncomment this line if you want to use locking. DynamoDB table terraform-state-lock-dynamo must be created.
    }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}

# These tags will be added to all resources
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
      StackName   = var.name
      Region      = var.region
      Managedby   = "Terraform IAC"
    }
  }
}
# Nitro challenge: EKS cluster & App deployment

Requirements listed in [TODO.md](https://github.com/amila-ku/nitro-challenge/blob/main/TODO.md)

# Implementation

This repository contains configurations to containerize the application, ci/cd pipeline and infrastructure as code for the application.

Terrafrom Code: [deploy/infrastructure](https://github.com/amila-ku/nitro-challenge/tree/main/deploy/infrastructure)
Pipeline: [.github/workflows/build.yaml](https://github.com/amila-ku/nitro-challenge/blob/main/.github/workflows/build.yaml)
Infrastructure validation: [validation/validate.sh](https://github.com/amila-ku/nitro-challenge/blob/main/validation/validate.sh)

## Design Decisions

- Terraform modules for eks & vpc are used to manage the time rather than building from scratch.
- AWS load balancer ingress controller is used for ingress handling.
- Github CI is used for CI/CD.
- No linter added since small file. Staticcheck could be added if needed.
- Multiple environment steps added in pipeline, but not active.
- DNS not configured due to time constraints.
- Infrastructure deployment pipeline is not created due to time limitation, should be done manually.

## Application Deployment

This depends on AWS EKS cluster, so EKS cluster should be deployed first or should be already available.

### Deploy EKS cluster with terraform
Change to the deploy/infrastructure/dev directory. Update cluster name, environement or other variables according to what you want to set.

```
terraform init
terraform plan
terraform apply
```

review resources and approve the plan.

### Build & Deployment Pipeline

[GitHub Repository] -> [GitHub Actions Workflow] -> [AWS ECR] -> [AWS EKS]


GitHub Actions Workflow:

Flow:

[Checkout code] -> [Setup environment] -> [Run tests] -> [Configure credentials] -> [Login to Amazon ECR] ->
[Build, tag, and push Docker image to Amazon ECR] -> [Update kube config for EKS cluster] -> [Deploy to EKS (DEV)]
-> [Smoke Test] -> [Prod Deployment]

Details:
  - Triggers on push to main branch or pull request
  - Environment Variables:
    - ECR_REPOSITORY: nitro-app
    - EKS_CLUSTER_NAME: nitro-dev
    - AWS_REGION: eu-west-1
    - HTTP_PORT: '8080'

Jobs: Build & Deploy:
- Checkout code
- Setup Go environment
- Run Go tests
- Configure AWS credentials
- Login to Amazon ECR
- Build, tag, and push Docker image to Amazon ECR
- Update kube config for EKS cluster
- Deploy to EKS (DEV):
    - Modify Kubernetes deployment manifests
    - Apply manifests using kubectl
- Test the deployed ingress endpoint

### Potential deployment to production steps are commented out.


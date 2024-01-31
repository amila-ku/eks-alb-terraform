# Nitro challenge: EKS cluster & App deployment

# Challenge: AWS EKS Deployment with Docker and Terraform Objective
In this challenge, you will be provided with a simple Go application that prints "Hello, World!" at the /hello endpoint. Your task is to package the application into a Docker container, create theoretical Terraform code to provision an EKS cluster and VPC on AWS, and implement a deployment pipeline to deploy the application onto the EKS cluster. This challenge will assess your expertise in Docker, AWS, Kubernetes, and CI/CD best practices.

Time Limit: There is no time limit but the task should not take longer than a couple of hours.
Note: You are not expected to complete all tasks within the time limit. You are not required to have access to an AWS account. Therefore, the Terraform code and pipeline should be designed to be theoretical and not require actual AWS credentials. Additionally, you can utilize diagrams to demonstrate the flow. Use markdown for the submission.

## Task 1: Dockerizing the Go Application
1. Create a Dockerfile to package the provided Go application into a Docker container. The Docker image should be based on a suitable
base image, and the application should listen on a configurable port via an environment variable.
2. Test the Docker image locally to ensure it works as expected, exposing the application on the correct port.

## Task 2: Theoretical Terraform EKS Cluster and VPC
1. Write theoretical Terraform code to provision an EKS cluster on AWS.
2. Include configuration for a VPC with public and private subnets across multiple availability zones.
3. Configure the EKS cluster with appropriate settings, including node instance type, desired Kubernetes version, and other relevant
parameters.
4. Use AWS provider blocks and data sources to interact with AWS services without requiring actual AWS account credentials.

## Task 3: Deployment Pipeline for EKS
1. Design a deployment pipeline using a CI/CD tool of your choice (e.g., Github Actions, GitLab CI, CircleCI, etc.). If you prefer, you can use a local Git repository to demonstrate the pipeline steps.
2. Ensure the pipeline triggers automatically whenever changes are pushed to the application's code repository (can be a theoretical repository).
3. The application should be available internally within the VPC by using a hostname that you can choose.
4. The application should be ready to deploy to multiple environments.
5. Include the following stages in the pipeline:

Build Stage: Build the Docker image of the Go application using the Dockerfile created in Task 1.
Test Stage: Run automated tests to ensure the application functions correctly within the Docker container. Push Stage: Push the Docker image to a container registry of your choice (theoretical registry).
Deploy Stage: Use kubectl (or equivalent) to deploy the application to the EKS cluster created in Task 2.

## Submission
Please upload the files to a private GitHub repository and add the following users as collaborators: 
javgo
harshaisgud 
armnitro

## Evaluation Criteria for task:
1. Docker Image: Evaluation will focus on the candidate's ability to create a Dockerfile that successfully packages the Go application and exposes the port through an environment variable.
2. Terraform Code: The quality, correctness, and adherence to best practices in the candidate's theoretical Terraform code for provisioning an EKS cluster and VPC on AWS will be assessed.
3. EKS Cluster Configuration: Evaluation will verify whether the candidate properly configures the EKS cluster with the appropriate settings and follows AWS best practices.
4. Deployment Pipeline: The candidate's ability to design and implement an efficient deployment pipeline for deploying the application to the EKS cluster and configuring the Ingress resource will be assessed.
5. CI/CD Best Practices: Assessment will include whether the candidate implements CI/CD best practices, including automated testing, versioned Docker image handling, and proper Ingress deployment.



# Implementation

This repository contains configurations to containerize the application, ci/cd pipeline and infrastructure as code for the application.

Terrafrom Code: deploy/infrastructure
Pipeline: .github/workflows/build.yaml
Infrastructure validation: validation/validate.sh

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


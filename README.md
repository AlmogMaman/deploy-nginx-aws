# NGINX Deployment on AWS

This project demonstrates how to deploy a custom NGINX instance on AWS using Terraform for infrastructure management, Docker for containerization, and GitHub Actions for CI/CD.

## Overview

Deploy an NGINX instance that will be publicly accessible and display the text "yo this is nginx" upon access.

## Prerequisites

- **AWS Account**: A free tier account is sufficient.
- **Terraform**: Must be installed. [Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **Docker**: Should be installed on your local machine for image testing.
- **Environment Variables**: Set the following:
  - `TF_VAR_AWS_ACCESS_KEY`: Your AWS access key.
  - `TF_VAR_AWS_SECRET_ACCESS_KEY`: Your AWS secret key.
- **AWS IAM User**: Create a user with EC2 and Elastic Load Balancer full permissions.

## Steps to Deploy the Infrastructure

### AWS Infrastructure Setup

1. **Virtual Private Cloud (VPC)**
   - Create a VPC.
   - Create two public subnets and one private subnet within the VPC.
2. **EC2 Instance**
   - Deploy the custom NGINX instance in the private subnet.
3. **Security Groups**
   - Configure security groups for the VPC, subnets, ALB, and the NGINX instance.
4. **NAT Gateway and EIP**
   - Set up a NAT gateway with an Elastic IP.
5. **Application Load Balancer (ALB)**
   - Configure the ALB for inbound traffic, ensuring high availability across the two public subnets.

### Infrastructure Deployment with Terraform

1. **Install Terraform**
   - Follow the [Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli).
2. **AWS IAM User Creation**
   - Create a user in the AWS console. It is recommended to avoid using root credentials for security reasons.
3. **AWS CLI Configuration**
   - Configure the AWS CLI with the newly created user credentials.
4. **Clone the Repository**
   - Clone the repository containing the Terraform scripts.
5. **Set Environment Variables**
   - Ensure the environment variables `TF_VAR_AWS_ACCESS_KEY` and `TF_VAR_AWS_SECRET_ACCESS_KEY` are set.
6. **Initialize Terraform**
   - Run `terraform init` to initialize the Terraform working directory.
7. **Plan the Deployment** (optional)
   - Run `terraform plan` to review the deployment plan.
8. **Apply the Deployment**
   - Run `terraform apply` to deploy the infrastructure.
9. **Access NGINX**
   - Access the NGINX instance via the ALB URL, which is output after applying the Terraform script.
10. **Destroy the Infrastructure**
    - Run `terraform destroy` to tear down the infrastructure.

## Docker Containerization

1. **Dockerfile Creation**
   - Create a Dockerfile for the custom NGINX instance.
2. **Build Docker Image**
   - Run `docker build -t <your-dockerhub-username>/custom-nginx .` to build the image.
3. **Local Testing**
   - Test the Docker image locally by running it.
4. **Docker Hub Login**
   - Login to Docker Hub using `docker login`.
5. **Push Docker Image**
   - Push the custom NGINX image to your Docker Hub account.

## Public Access

- The NGINX instance will be accessible via the browser and will return the text "yo this is nginx."
- The instance is deployed in a private subnet and is accessed through the ALB.

## Bonus: GitHub Workflows for CI/CD

1. **Deployment Workflow**
   - Triggered on changes to the main branch, it builds the infrastructure and deploys the application.
   - Can be manually triggered.
2. **Destruction Workflow**
   - Triggered on changes to the dev branch, it destroys the infrastructure.
   - Can be manually triggered.
3. **Workflow Authentication**
   - Uses GitHub repository secrets for authentication.

## Authentication

- Preferred method: Environment variables to streamline the GitHub Actions deployment process.

## NAT Instance Selection

- Chosen over NAT gateway for cost-effectiveness and configuration flexibility.
- Suitable for simple architectures; robust architectures might benefit more from a NAT gateway.
- Facilitates outbound traffic from the private subnet to the public subnet and the internet.

## Terraform Usage

1. **Initialization**
   - `terraform init` to download relevant providers/modules.
2. **Validation**
   - `terraform validate` to check the code.
3. **Planning**
   - `terraform plan` for a dry run.
4. **Application**
   - `terraform apply` to deploy the infrastructure.
   - Optional: Use `--auto-approve` for non-interactive execution.
5. **Destruction**
   - `terraform destroy` to tear down the infrastructure.
   - Optional: Use `--auto-approve` for non-interactive execution.

## Backend Management

- Configured for managing Terraform state files both locally and within GitHub workflows.

---

Follow these steps to successfully deploy a custom NGINX instance on AWS using Terraform, Docker, and GitHub Actions. For more detailed instructions, refer to the comments within the Terraform scripts and Dockerfile.

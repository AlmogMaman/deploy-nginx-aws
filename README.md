# Flask App Deployment on AWS

This project demonstrates how to deploy a custom flask app instance on AWS using Terraform for infrastructure management, Docker for containerization, and GitHub Actions for CD.

## Overview

Deploy an flask app instance within a private subnet, ensuring secure access through an Application Load Balancer (ALB) and a NAT gateway. The flask app instance will display simple UI upon access.

## Prerequisites

- **AWS Account**: A free tier account is sufficient.
- **AWS IAM User**: Create a user with EC2 and Elastic Load Balancer full permissions.
- **Terraform**: Must be installed. [Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **Docker**: Should be installed on your local machine for image testing. (optional)
- **Environment Variables**: Set the following:
  - `TF_VAR_AWS_ACCESS_KEY`: Your AWS access key.
  - `TF_VAR_AWS_SECRET_ACCESS_KEY`: Your AWS secret key.

## Steps to Deploy the Infrastructure

### AWS Infrastructure main Resources

1. **Virtual Private Cloud (VPC)**

2. **2 Public subnets (High Availability)**

3. **Private subnet**

4. **EC2 Instance (custom flask app instance deployed in the private subnet)**

5. **Security Groups**
   - Configured security groups for the VPC, ALB, and the flask app instance.

6. **NAT Gateway with EIP**

7. **Application Load Balancer (ALB)**
   - ensuring high availability across the two public subnets.

![DIAGRAM](Diagrams/Cloud_Architecture.png)

### Infrastructure Deployment with Terraform
1. **Cloning the repo**
2. **Initialize Terraform**
   - Run `terraform init` to initialize the Terraform working directory.
3. **Plan the Deployment** (optional)
   - Run `terraform plan` to review the deployment plan.
4. **Apply the Deployment**
   - Run `terraform apply` to deploy the infrastructure.
5. **Access flask app**
   - Access the flask app instance trough the browser via the ALB URL, which is output after applying the terraform apply command.
6. **Destroy the Infrastructure**
    - Run `terraform destroy` to tear down the infrastructure.

## Docker Containerization - Explanation
1. **Dockerfile Creation**
   - I created a Dockerfile for the custom flask app instance.
2. **I Built Docker Image**
   - I ran `docker build -t almogmaman762/custom-flask app .` to build the image.
3. **Local Testing**
   - I tested the Docker image locally by running it `docker run -p 80:80 almogmaman762/custom-flask app`.
4. **Docker Hub Login**
   - Logged to Docker Hub using `docker login` with my docker Hub credentials.
5. **Pushed Docker Image**
   - I pushed the custom flask app image to my Docker Hub account.

## Local Access

![LOCAL_ACCESS](Images/custom-flask app-local-running.PNG)


## Public Access

- The flask app instance will be accessible via the browser and will return the text "yo this is flask app."
- The instance is deployed in a private subnet and is accessed through the ALB that load balance from 2 public subnets (High Availability).

![PUBLIC_ACCESS](Images/access-via-browser-aws.PNG)


## GitHub Workflows for CD

1. **Deployment Workflow**
   - Triggered on changes to the main branch, it builds the infrastructure and deploys the application.
   - Can be manually triggered.
   - Destroy the infrastructure when done
2. **Workflow Authentication**
   - Uses GitHub repository secrets for authentication.


![DEPLOY_WORKFLOW](Images/deploy-workflow.PNG)


## Authentication

- Preferred method: Environment variables to streamline the GitHub Actions deployment process.
- And make the deployment a bit faster :) (no need to install AWS CLI)


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

# AWS Production-style Flask Aoo Infrastructure with Terraform

This project demonstrates a production-style AWS infrastructure built with Terraform. It deploys a Flask application on private EC2 instances behind an Application Load Balancer, with Auto Scaling, secure networking, RDS, and Systems Manager access.

## 🌟 Why This Architecture is Robust

* **Zero Manual IP Management**: 
    The system uses an **Application Load Balancer (ALB)** combined with an **Auto Scaling Group (ASG)**. 
    - You don't need to track or hardcode EC2 IP addresses. 
    - The ALB automatically handles health checks and routes traffic to live instances, even as they scale in or out.
* **Security Through Isolation**: 
    EC2 instances are hosted in **Private Subnets** without public IP addresses, making them invisible to the direct internet and significantly reducing the attack surface.

## Architecture Overview

The Infrastructure includes:

- A custom VPC
- Public subnets for the ALB
- Private subnets for EC2 instances in an Auto Scaling Group
- Private database subnets for Amazon RDS
- Internet Gateway and NAT Gateway
- SG for ALB, app tier, and database tier
- SSM access for private EC2 instances
- Flask application served by Gunicorn
- Nginx recerse proxy in forn of Flask
- RDS deployed in private DB subnets

## Final Architecture

```text
Internet
   |
   v
Application Load Balancer (Public Subnets)
   |
   v
Auto Scaling Group of EC2 Instances (Private App Subnets)
   |
   v
Nginx -> Gunicorn -> Flask App
   |
   v
Amazon RDS (Private DB Subnets)

## Prerequisties & Customization

Before running "terraform apply", you must update a few placeholders to match your own AWS environment:

### 1. AWS Credentials
Ensure your AWS CLI is configured with the correct permissions:
'''bash
aws configure

### 2. Variable Configuration
Update `terraform.tfvars` with your own key pair name before running Terraform.
Set your own db_username and db_password.
Specify your target AWS region. 

### 3. SSH Key Access
If you choose to use traditional SSH instead of SSM, ensure your .pem file permissions are set correctly:
chmod 400 your-key.pem 

##Deployment instructions
terraform fmt -recursive
terraform init
terraform validate
terraform plan
terraform apply -auto-approve

clean up: terraform destroy
 


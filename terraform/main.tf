terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  project_name              = var.project_name
  vpc_cidr                  = "10.0.0.0/16"
  public_subnet_1_cidr      = "10.0.11.0/24"
  public_subnet_2_cidr      = "10.0.12.0/24"
  private_app_subnet_1_cidr = "10.0.21.0/24"
  private_app_subnet_2_cidr = "10.0.22.0/24"
  private_db_subnet_1_cidr  = "10.0.31.0/24"
  private_db_subnet_2_cidr  = "10.0.32.0/24"
  az_1                      = "us-east-1a"
  az_2                      = "us-east-1b"
}

module "sg" {
  source       = "./modules/sg"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "ec2" {
  source                = "./modules/ec2"
  project_name          = var.project_name
  subnet_id             = module.vpc.public_subnet_1_id
  security_group_id     = module.sg.ec2_sg_id
  ami_id                = "ami-02dfbd4ff395f2a1b"
  instance_type         = var.instance_type
  instance_profile_name = module.iam_ec2_ssm.instance_profile_name
}

module "alb" {
  source       = "./modules/alb"
  project_name = var.project_name

  vpc_id      = module.vpc.vpc_id
  subnet_1_id = module.vpc.public_subnet_1_id
  subnet_2_id = module.vpc.public_subnet_2_id
  alb_sg_id   = module.sg.alb_sg_id
}

module "asg" {
  source = "./modules/asg"

  project_name          = var.project_name
  ami_id                = "ami-02dfbd4ff395f2a1b"
  instance_type         = "t2.micro"
  security_group_id     = module.sg.ec2_sg_id
  instance_profile_name = module.iam_ec2_ssm.instance_profile_name

  subnet_1_id = module.vpc.private_app_subnet_1_id
  subnet_2_id = module.vpc.private_app_subnet_2_id

  target_group_arn = module.alb.target_group_arn
}

module "rds" {
  source = "./modules/rds"

  project_name   = var.project_name
  db_subnet_1_id = module.vpc.private_db_subnet_1_id
  db_subnet_2_id = module.vpc.private_db_subnet_2_id
  db_sg_id       = module.sg.db_sg_id

  db_name     = "qiaoudoudb"
  db_username = "adminuser"
  db_password = "ChangeThis12345!"
}

module "iam_ec2_ssm" {
  source = "./modules/iam_ec2_ssm"
}
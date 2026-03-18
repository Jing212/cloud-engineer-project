variable "project_name" {
  description = "Project name"
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name for SSH access"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-02dfbd4ff395f2a1b" # 也可以不写 default，在 terraform.tfvars 中指定
}
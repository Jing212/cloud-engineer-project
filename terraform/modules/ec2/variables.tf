variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the EC2 instance"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name for SSM access"
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name for SSH access"
  type        = string
  default     = null
}
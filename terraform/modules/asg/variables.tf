variable "project_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  description = "Optional EC2 key pair name for SSH access"
  type        = string
  default     = null
}

variable "security_group_id" {
  type = string
}

variable "subnet_1_id" {
  type = string
}

variable "subnet_2_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name for EC2 SSM access"
  type        = string
}
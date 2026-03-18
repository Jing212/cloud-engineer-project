variable "project_name" {
  description = "Project name"
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name for SSH access"
  type        = string
  default     = null
}
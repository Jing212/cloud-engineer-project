variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.11.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.12.0/24"
}

variable "private_app_subnet_1_cidr" {
  description = "CIDR block for private app subnet 1"
  type        = string
  default     = "10.0.21.0/24"
}

variable "private_app_subnet_2_cidr" {
  description = "CIDR block for private app subnet 2"
  type        = string
  default     = "10.0.22.0/24"
}

variable "private_db_subnet_1_cidr" {
  description = "CIDR block for private db subnet 1"
  type        = string
  default     = "10.0.31.0/24"
}

variable "private_db_subnet_2_cidr" {
  description = "CIDR block for private db subnet 2"
  type        = string
  default     = "10.0.32.0/24"
}

variable "az_1" {
  description = "Availability zone for public subnet 1"
  type        = string
  default     = "us-east-1a"
}

variable "az_2" {
  description = "Availability zone for public subnet 2"
  type        = string
  default     = "us-east-1b"
}
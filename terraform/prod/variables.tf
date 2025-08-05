variable "aws_region" {
  description = "AWS region for prod resources"
  type        = string
  default     = "us-east-1"
}

variable "prod_instance_type" {
  description = "EC2 instance type for prod"
  type        = string
  default     = "t3.small"
}

variable "ssh_key_name" {
  description = "Name of the existing AWS key pair for SSH access"
  type        = string
}

variable "aws_region" {
  description = "AWS region for dev resources"
  type        = string
  default     = "us-east-1"
}

variable "dev_instance_type" {
  description = "EC2 instance type for dev"
  type        = string
  default     = "t3.micro"
}

variable "ssh_key_name" {
  description = "Name of the existing AWS key pair for SSH access"
  type        = string
}

variable "install_dotfiles" {
  description = "Set to true to install developer dotfiles"
  type        = bool
  default     = false
}

output "prod_instance_public_ip" {
  description = "Public IP of the prod EC2 instance"
  value       = aws_instance.prod.public_ip
}

output "dev_instance_public_ip" {
  description = "Public IP of the dev EC2 instance"
  value       = aws_instance.dev.public_ip
}

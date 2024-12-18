output "public_ips" {
  value = aws_instance.public[*].public_ip
  description = "The public IPs of the EC2 instances"
}
output "ec2_instance_ids_public" {
  value = aws_instance.public[*].id  # Reference the output from the EC2 module
}
output "public_security_group" {
  value = aws_security_group.public_security_group.id
  
}
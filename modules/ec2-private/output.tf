output "ec2_instance_ids-private" {
  value = aws_instance.private[*].id  # Assuming you're using a list of instances
  description = "The IDs of the EC2 instances"
}
output "private_ips" {
  value = aws_instance.private[*].private_ip
  description = "The private IPs of the EC2 instances"
}
output "private_security_group" {
  value=aws_security_group.private_security_group.id
  
}
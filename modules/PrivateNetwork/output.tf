output "private_subnet_ids" {
  value = aws_subnet.private[*].id  # Replace with your actual subnet ID logic
}
output "nat_gateway_public_ip" {
  value = aws_eip.nat.public_ip  # This will output the public IP of the NAT Gateway
  description = "The public IP of the NAT Gateway"
}

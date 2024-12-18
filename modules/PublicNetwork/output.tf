output "public_subnet_ids" {
  value = aws_subnet.public[*].id  # Access all public subnet IDs created with count
  description = "The IDs of the public subnets"
}

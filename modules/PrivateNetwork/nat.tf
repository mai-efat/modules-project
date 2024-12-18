resource "aws_eip" "nat" {
  
}
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id  # Replace with the public subnet ID

  tags = {
    Name = "Main-NAT-Gateway"
  }
}



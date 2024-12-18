resource "aws_subnet" "public" {
    count = length(var.public_subnets)  # Reference to the number of public subnets
    vpc_id            = var.vpc_id  # Reference to the VPC
    cidr_block        = var.public_subnets[count.index]  # CIDR block for public subnet
    availability_zone = var.availability_zones[count.index]  # Use statically defined AZs
    map_public_ip_on_launch = true  # Enable public IPs on launch (public subnet)
    tags = {
        Name = "public-subnet-${count.index + 1}"
    }
}

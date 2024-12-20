resource "aws_efs_file_system" "EFS" {
  creation_token = "efs"
  performance_mode = "generalPurpose"  
  encrypted = true  
  

  tags = {
    Name = "EFS"
  }
}
resource "aws_efs_mount_target" "mount_target" {
   for_each = {
    for idx, subnet in var.public_subnets : "subnet-${idx}" => subnet
  }
  file_system_id  = aws_efs_file_system.EFS.id
  subnet_id       = each.value                 # Current subnet in the loop
  security_groups = [aws_security_group.efs_sg.id]

}
resource "aws_security_group" "efs_sg" {
  name        = "efs-security-group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
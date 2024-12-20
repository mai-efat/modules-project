resource "aws_instance" "private" {
  count             = length(var.private_subnet_ids)  # Creates one instance per subnet ID
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  subnet_id         = var.private_subnet_ids[count.index]  # Assigns the correct subnet ID based on the index
  associate_public_ip_address = false  # Instances in private subnets should not get a public IP
  key_name          = "nginx"
  security_groups   = [aws_security_group.private_security_group.id]
    user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl enable apache2
              systemctl start apache2
              EOF

  tags = {
    Name = "Private-EC2-${count.index + 1}"
  }

  lifecycle {
    ignore_changes = [
      ami,                       # Ignore changes to AMI (useful if you want to manually update AMI)
      security_groups,           # Ignore changes to the security group (to avoid replacement)
      subnet_id                  # Ignore changes to subnet ID
    ]
  }
}

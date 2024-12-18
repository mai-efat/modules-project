resource "aws_instance" "public" {
  count             = length(var.public_subnet_ids)  # Creates one instance per subnet ID
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_ids[count.index]  # Assigns the correct subnet ID based on the index
  associate_public_ip_address = true  # Instances in private subnets should not get a public IP
  key_name          = "key"
  security_groups   = [aws_security_group.public_security_group.id]
    user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "Public-EC2-${count.index + 1}"
  }
}

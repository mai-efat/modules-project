resource "aws_instance" "public" {
  count                     = length(var.public_subnet_ids)  # One instance per subnet
  ami                       = data.aws_ami.ubuntu.id
  instance_type             = var.instance_type
  subnet_id                 = var.public_subnet_ids[count.index]  # Correct subnet assignment
  associate_public_ip_address = true  # Assign public IP for instances in public subnets
  key_name                  = "nginx"
  security_groups           = [aws_security_group.public_security_group.id]
  

  # User data script to install and configure nginx
   user_data = <<-EOF
    #!/bin/bash
    # Install EFS utilities
    yum install -y amazon-efs-utils

    # Create mount directory
    mkdir -p /mnt/efs

    # Mount EFS using DNS
    mount -t efs ${var.efs_id}:/ /mnt/efs

    # Persist the mount in /etc/fstab
    echo "${var.efs_id}:/ /mnt/efs efs defaults,_netdev 0 0" >> /etc/fstab
  EOF

  tags = {
    Name = "Public-EC2-${count.index + 1}"
  }

  # Connection block for remote-exec provisioner
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/mai/Downloads/nginx.pem")  # Correct private key path
    host        = self.public_ip  # Correct instance host reference
  }

  # Remote execution for Nginx installation and additional configuration
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nfs-common",
      "sudo mkdir -p /mnt/efs",
      "sudo mount -t nfs4 -o nfsvers=4.1 ${var.efs_id}:/ /mnt/efs",
      "echo '${var.efs_id}:/ /mnt/efs nfs4 defaults,_netdev 0 0' | sudo tee -a /etc/fstab",
      "echo 'Updating system packages...'",
      "sudo apt update -y",
      "echo 'Installing Nginx...'",
      "sudo apt install nginx -y",
      "echo 'Enabling Nginx to start on boot...'",
      "sudo systemctl enable nginx",
      "echo 'Starting Nginx service...'",
      "sudo systemctl start nginx",
      "echo 'Creating Nginx configuration for proxy pass...'",
      
      # Modify the Nginx configuration to point to the load balancer's private IP or DNS
      "echo 'server {' | sudo tee /etc/nginx/sites-available/default > /dev/null",  # Use sudo for writing to file
      "echo '  listen 80;' | sudo tee -a /etc/nginx/sites-available/default > /dev/null", 
      "echo '  location / {' | sudo tee -a /etc/nginx/sites-available/default > /dev/null", 
      "echo '    proxy_pass http://${var.load_balancer_dns};' | sudo tee -a /etc/nginx/sites-available/default > /dev/null",  # Use private DNS here
      "echo '    proxy_set_header Host $host;' | sudo tee -a /etc/nginx/sites-available/default > /dev/null",
      "echo '    proxy_set_header X-Real-IP $remote_addr;' | sudo tee -a /etc/nginx/sites-available/default > /dev/null",
      "echo '    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;' | sudo tee -a /etc/nginx/sites-available/default > /dev/null",
      "echo '    proxy_set_header X-Forwarded-Proto $scheme;' | sudo tee -a /etc/nginx/sites-available/default > /dev/null",
      "echo '  }' | sudo tee -a /etc/nginx/sites-available/default > /dev/null",
      "echo '}' | sudo tee -a /etc/nginx/sites-available/default > /dev/null",

      "echo 'Nginx configuration created...'",
      "sudo systemctl restart nginx"
    ]
  }

  lifecycle {
    ignore_changes = [
      ami,                       # Ignore changes to AMI (useful if you want to manually update AMI)
      security_groups,           # Ignore changes to the security group (to avoid replacement)
      subnet_id                  # Ignore changes to subnet ID
    ]
  }
}

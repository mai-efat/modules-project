
resource "null_resource" "print_ips" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Private IPs of EC2 instances" > ec2_ips.txt
      for ip in ${join(" ", module.ec2-private.private_ips)}; do
        echo "private IP: $ip ">> ec2_ips.txt
      done
      # Add a separator for public IPs
      echo "" >> ec2_ips.txt
      echo "Public IPs of EC2 instances" >> ec2_ips.txt

      # Loop through and print the public IPs (you may need to update the module path if public IPs are in a separate module)
      for ip in ${join(" ", module.ec2-public.public_ips)}; do
        echo "public IP: $ip" >> ec2_ips.txt
      done
       
    EOT
  }

  depends_on = [module.ec2-private]
}
provider "aws" {
  region = "us-east-1"  # Adjust the region to match your setup
}

# Query Route 53 to find the hosted zone for app.com
data "aws_route53_zone" "app" {
  name = "app.com."  # Replace with your actual domain name
}

# Create a CNAME record for www.app.com
resource "aws_route53_record" "app_record" {
  zone_id = data.aws_route53_zone.app.zone_id  # Use the zone_id from the data source
  name    = "www.app.com"  # The subdomain for your application
  type    = "CNAME"  # CNAME record type, points to the ALB DNS name

  ttl     = 300  # Optional TTL (Time to Live) for caching DNS information
  records = [
    var.alb_public_dns  # This should be the public DNS name of your Application Load Balancer
  ]
}

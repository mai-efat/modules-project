output "alb_public_dns" {
  value = aws_lb.elb-public.dns_name  # Reference to the ALB's DNS name
  description = "The public DNS name of the Application Load Balancer"
}
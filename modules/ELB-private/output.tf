output "load_balancer_dns" {
  value = aws_lb.elb-private.dns_name
  description = "The DNS name of the Load Balancer"
}

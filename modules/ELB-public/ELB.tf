resource "aws_lb" "elb-public" {
  name               = "ELB-public"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_security_group_id]
  subnets            = [var.public_subnet_ids[0],var.public_subnet_ids[1]]

    enable_deletion_protection = false  # Set this to false to disable deletion protection

  tags = {
    Environment = "ELB-public"
  }
}
resource "aws_lb_listener" "my_alb_listener" {
 load_balancer_arn = aws_lb.elb-public.arn
 port              = "80"
 protocol          = "HTTP"

 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.targetgroup.arn
 }
}
resource "aws_lb_target_group" "targetgroup" {
  name     = "target-group-public"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "TargetGroup-public"
  }
}
resource "aws_lb_target_group_attachment" "public" {
  count             = length(var.ec2_instance_ids_public)  # Loop over the list of EC2 instance IDs
  target_group_arn  = aws_lb_target_group.targetgroup.arn
  target_id         = var.ec2_instance_ids_public[count.index]  # Directly use the EC2 instance ID from the list
  port              = 80
}


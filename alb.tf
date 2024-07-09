resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_1.id]  
  security_groups    = [aws_security_group.alb_sg.id]

  enable_deletion_protection = false

  tags = {
    Name = "web-application-load-balancer"
  }
}


resource "aws_lb_target_group" "nginx_target_group" {
  name     = "nginx-target-group"
  port     = var.valid_port
  protocol = var.alb_layer7_protocol
  vpc_id   = aws_vpc.main-vpc.id

  health_check {
    enabled             = true
    interval            = 30
    protocol            = var.alb_layer7_protocol
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name = "nginx-target-group"
  }
}

# HTTP listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.valid_port
  protocol          = var.alb_layer7_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_target_group.arn
  }
}

# Attach EC2 instances to the target group
resource "aws_lb_target_group_attachment" "nginx_tg_attachment" {
  target_group_arn = aws_lb_target_group.nginx_target_group.arn
  target_id        = aws_instance.nginx_instance.id
  port             = var.valid_port
}


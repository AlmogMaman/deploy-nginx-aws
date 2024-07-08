# # Define the ALB
# resource "aws_lb" "web_alb" {
#   name               = "web-alb"
#   internal           = false
#   load_balancer_type = "application"
#   subnets            = [aws_subnet.public_subnet.id]  # Ensure you have defined this subnet in your network configurations
#   security_groups    = [aws_security_group.alb_sg.id] # Ensure you have defined this security group in your security configurations

#   enable_deletion_protection = false

#   tags = {
#     Name = "WebApplicationLoadBalancer"
#   }
# }

# # Define the target group for nginx instances
# resource "aws_lb_target_group" "nginx_target_group" {
#   name     = "nginx-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id  # Ensure your VPC is defined elsewhere in your configuration

#   health_check {
#     enabled             = true
#     interval            = 30
#     protocol            = "HTTP"
#     path                = "/"
#     healthy_threshold   = 3
#     unhealthy_threshold = 3
#     timeout             = 5
#     matcher             = "200"
#   }

#   tags = {
#     Name = "NginxTargetGroup"
#   }
# }

# # HTTP listener
# resource "aws_lb_listener" "http_listener" {
#   load_balancer_arn = aws_lb.web_alb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.nginx_target_group.arn
#   }
# }

# # HTTPS listener - if you want to support HTTPS
# resource "aws_lb_listener" "https_listener" {
#   load_balancer_arn = aws_lb.web_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:acm:your-region:your-account-id:certificate/your-certificate-id"  # Update with your actual certificate ARN

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.nginx_target_group.arn
#   }
# }

# # Attach EC2 instances to the target group
# resource "aws_lb_target_group_attachment" "nginx" {
#   target_group_arn = aws_lb_target_group.nginx_target_group.arn
#   target_id        = aws_instance.nginx.id  # Ensure your EC2 instance is defined elsewhere in your configuration
#   port             = 80
# }


#resource "aws_security_group" "alb_sg" {
#   name        = "alb-security-group"
#   description = "Security group for ALB that allows web traffic"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Allow all incoming traffic on HTTP port
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]  # Allow all incoming traffic on HTTPS port
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
#   }

#   tags = {
#     Name = "alb_sg"
#   }
# }

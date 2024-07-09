resource "aws_instance" "nginx_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.nginx_instance_type
  subnet_id     = aws_subnet.private_subnet.id

  security_groups = [aws_security_group.nginx_instance_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo docker run -d -p 80:80 almogmaman762/custom-nginx
              EOF

  tags = {
    Name = "nginx-instance"
  }
}


output "alb_dns" {
    value = aws_lb.alb.dns_name
}

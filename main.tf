resource "aws_instance" "app_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.app_instance_type
  subnet_id     = aws_subnet.private_subnet.id

  security_groups = [aws_security_group.app_instance_sg.id]

  #I tried seperated vars. but it fails for some reason. I mean for the ports and image seperately
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo docker run -d -p ${var.app_ports_and_image}
              EOF

  tags = {
    Name = "app-instance"
  }
}


output "alb_dns" {
    value = aws_lb.alb.dns_name
}

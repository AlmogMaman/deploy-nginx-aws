resource "aws_instance" "nginx" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet.id

  security_groups = [aws_security_group.private_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker
              sudo service docker start
              sudo docker run -d -p ${var.ports} ${var.image}
              EOF

  tags = {
    Name = "nginx-instance"
  }
}

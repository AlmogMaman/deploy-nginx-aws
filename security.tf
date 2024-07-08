#Security group for the vpc.
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [var.all_ip]
  }

  egress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [var.all_ip]
  }
}

#SG for the instange
resource "aws_security_group" "instance_sg" {
  name        = "instance-sg"
  description = "Security group for the instance in private subnet"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [aws_instance.nat_instance.ip] #Can only contanct with the nat instance. for security reasons.
  }

  egress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [aws_instance.nat_instance.ip] #Can only contanct with the nat instance. for security reasons.
  }

  tags = {
    Name = "private-instance-sg"
  }
}


# Security Group for NAT Instance
resource "aws_security_group" "nat_sg" {
  vpc_id = aws_vpc.main-vpc.id

  # Allow all outgoing traffic for certain port and protocol
  egress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [var.all_ip]
  }

  # Allow all incoming traffic for certain port and protocol
  ingress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [var.all_ip]
  }
}

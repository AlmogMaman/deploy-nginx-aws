#Security group for the vpc.
#Another layer of security
resource "aws_security_group" "vpc_sg" {
  name        = "vpc-sg"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [var.all_ip]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ip]
  }
  tags = {
    Name = "vpc-sg"
  }
}

#SG for the instange
resource "aws_security_group" "app_instance_sg" {
  name        = "instance-sg"
  description = "Security group for the instance in private subnet"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [var.public_subnet_cidr,var.public_subnet_1_cidr]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ip]
  }
  
  tags = {
    Name = "instance-sg"
  }
}



#SG for the alb
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for alb that allows web traffic"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ip]
  }
  
  #The ALB can send traffic only to the private subnet.
  egress {
    from_port   = var.valid_port
    to_port     = var.valid_port
    protocol    = var.valid_layer4_protocol
    cidr_blocks = [var.private_subnet_cidr]
  }

  tags = {
    Name = "alb-sg"
  }
}
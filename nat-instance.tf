resource "aws_eip" "nat_eip" {
  tags = {
    Name = "nat-instance-eip"
  }
}


# NAT Instance
resource "aws_instance" "nat_instance" {
  ami           = var.nat_instance_ami
  instance_type = var.instance_ami
  subnet_id     = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.nat_sg.id]

  tags = {
    Name = "nat-instance"
  }
}

# Attach the Elastic IP to the NAT instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.nat_instance.id
  allocation_id = aws_eip.nat_eip.id
}



# Route table for the private subnet
resource "aws_route" "private_route_to_nat" {
  route_table_id         = aws_route_table.private_subnet.id
  destination_cidr_block = [aws_instance.nginx.ip] #Associated only with nginx instance for more security.
  instance_id            = aws_instance.nat_instance.id
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

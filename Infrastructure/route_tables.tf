#For the private subnet.
resource "aws_route_table" "private_subnet_rt" {
  vpc_id = aws_vpc.main-vpc.id
}


#Route for the private subnet RT
resource "aws_route" "private_route_to_nat" {
  route_table_id         = aws_route_table.private_subnet_rt.id
  #In this case the 0.0.0.0/0 means any ip that not inside the subnet. 
  #this does not meann accees to the public internet directly.
  destination_cidr_block = var.all_ip
  nat_gateway_id = aws_nat_gateway.nat_gateway.id #Attach to the nat gateway for outbound traffic.
}


resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_subnet_rt.id
}



resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-vpc.id
}

#For the public subnet
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = var.all_ip
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}

#For the public subnet - HA for the ALB
resource "aws_route_table" "public_subnet_route_table_1" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = var.all_ip
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_subnet_route_table_1.id
}


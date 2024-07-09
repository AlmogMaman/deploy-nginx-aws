resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_a
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.private_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = var.availability_zone_a
  tags = {
    Name = "private-subnet"
  }
}


#This subnet exsts for the high avalabilty for the ALB
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.public_subnet_1_cidr
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_b
  tags = {
    Name = "public-subnet-1"
  }
}

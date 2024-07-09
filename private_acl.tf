resource "aws_network_acl" "private_subnet_acl" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "private-subnet-acl"
  }
}

#Can get traffic only from the public subnet. not from the public Internet directly.Another security layer
# Inbound rules
resource "aws_network_acl_rule" "private_subnet_inbound_traffic" {
  network_acl_id = aws_network_acl.private_subnet_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = var.valid_layer4_protocol
  from_port      = var.valid_port
  to_port        = var.valid_port
  cidr_block     = var.public_subnet_cidr
  egress         = false
}
resource "aws_network_acl_rule" "private_subnet_inbound_traffic_1" {
  network_acl_id = aws_network_acl.private_subnet_acl.id
  rule_number    = 200
  rule_action    = "allow"
  protocol       = var.valid_layer4_protocol
  from_port      = var.valid_port
  to_port        = var.valid_port
  cidr_block     = var.public_subnet_1_cidr 
  egress         = false
}


# Outbound rules
resource "aws_network_acl_rule" "private_subnet_outbound_traffic" {
  network_acl_id = aws_network_acl.private_subnet_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.all_ip
  egress         = true
}

# Associate with a subnet
resource "aws_network_acl_association" "private_subnet_association" {
  network_acl_id = aws_network_acl.private_subnet_acl.id
  subnet_id      = aws_subnet.private_subnet.id
}

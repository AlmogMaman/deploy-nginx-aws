resource "aws_network_acl" "public_subnet_acl" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "public-subnet-acl"
  }
}

# Inbound rules
resource "aws_network_acl_rule" "inbound_traffic" {
  network_acl_id = aws_network_acl.public_subnet_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = var.valid_layer4_protocol
  from_port      = var.valid_port
  to_port        = var.valid_port
  cidr_block     = var.all_ip
  egress         = false
}

# Outbound rules
resource "aws_network_acl_rule" "outbound_traffic" {
  network_acl_id = aws_network_acl.public_subnet_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = var.valid_layer4_protocol
  from_port      = var.valid_port
  to_port        = var.valid_port
  cidr_block     = var.all_ip
  egress         = true
}

# Associate with a subnet
resource "aws_network_acl_association" "public_subnet_association" {
  network_acl_id = aws_network_acl.public_subnet_acl.id
  subnet_id      = aws_subnet.public_subnet.id
}

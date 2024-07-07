resource "aws_network_acl" "public_network_acl" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "PublicSubnetACL"
  }
}

# Inbound rules
resource "aws_network_acl_rule" "inbound_http" {
  network_acl_id = aws_network_acl.public_network_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "tcp"
  from_port      = 80
  to_port        = 80
  cidr_block     = "0.0.0.0/0"
  egress         = false
}

resource "aws_network_acl_rule" "inbound_https" {
  network_acl_id = aws_network_acl.public_network_acl.id
  rule_number    = 110
  rule_action    = "allow"
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  cidr_block     = "0.0.0.0/0"
  egress         = false
}

# Outbound rules
resource "aws_network_acl_rule" "outbound_all" {
  network_acl_id = aws_network_acl.public_network_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"  # All protocols
  from_port      = 0
  to_port        = 0
  cidr_block     = "0.0.0.0/0"
  egress         = true
}

# Associate with a subnet
resource "aws_network_acl_association" "public_subnet_association" {
  network_acl_id = aws_network_acl.public_network_acl.id
  subnet_id      = aws_subnet.public_subnet.id
}

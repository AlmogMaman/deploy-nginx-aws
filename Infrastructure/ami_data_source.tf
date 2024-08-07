data "aws_ami" "latest_amazon_linux" {
  owners = ["137112412989"] 
  # Filter for the latest Amazon Linux AMI
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Pattern to match Amazon Linux 2 AMIs
  }
  # Ensure the AMI is available
  filter {
    name   = "state"
    values = ["available"]
  }
  # Sort to get the most recent AMI
  most_recent = true
}

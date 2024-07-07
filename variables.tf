#Locations
variable "region" {
  type = string
  default = "us-west-2"
}
variable "availability_zone_a" {
  type = string
  default = "us-west-2a"
}
variable "availability_zone_b" {
  type = string
  default = "us-west-2b"
}

#Compute
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "machine_ami" {
  type = string
  default = ""
}

#Networking
variable "all_ip" {
  type = string
  default = "0.0.0.0/0"
}
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
}
variable "private_subnet_cidr" {
  type = string
  default = "10.0.2.0/24"
}


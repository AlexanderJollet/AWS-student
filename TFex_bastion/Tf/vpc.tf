resource "aws_vpc" "vpc_instance_1" {
  cidr_block = var.subnet
}

resource "aws_subnet" "subnet_instance_1" {
  vpc_id                  = aws_vpc.vpc_instance_1.id
  cidr_block              = var.subnet
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.vpc_instance_1.id
}

resource "aws_route" "wan_access" {
  route_table_id         = aws_vpc.vpc_instance_1.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}


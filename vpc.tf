## Creating VPC ##
resource "aws_vpc" "kubernetes" {
  cidr_block = "10.43.0.0/16"
  enable_dns_hostnames = true
}

##Creating Subnet###
resource "aws_subnet" "kubernetes" {
  vpc_id = aws_vpc.kubernetes.id
  cidr_block = "10.43.0.0/16"
  availability_zone = "us-east-1a"
}

##Creating Internet Gateway##
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kubernetes.id
}

##Creating Internet Route table##
resource "aws_route_table" "kubernetes" {
    vpc_id = aws_vpc.kubernetes.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id
    }
}

resource "aws_route_table_association" "kubernetes" {
  subnet_id = aws_subnet.kubernetes.id
  route_table_id = aws_route_table.kubernetes.id
}
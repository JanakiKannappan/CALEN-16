#VPC
resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  

  tags = {
    Name = "MyTerraformVPC"
  }
}

#subnets
resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

}

resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
}

#Internet Gateway
resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.myvpc.id
}

#Route table
resource "aws_route_table" "Routetable" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }
}

resource "aws_route_table_association" "RTassociation" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.Routetable.id
}


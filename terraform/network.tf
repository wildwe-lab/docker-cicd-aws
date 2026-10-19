resource "aws_vpc" "docker-cicd-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "docker-cicd-vpc"
  }
}

resource "aws_subnet" "docker-cicd-public-1" {
  vpc_id                  = aws_vpc.docker-cicd-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "docker-cicd-public-1"
  }
}
resource "aws_subnet" "docker-cicd-public-2" {
  vpc_id                  = aws_vpc.docker-cicd-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "docker-cicd-public-2"
  }
}
resource "aws_internet_gateway" "docker-cicd-igw" {
    vpc_id = aws_vpc.docker-cicd-vpc.id

 tags = {
    Name = "docker-cicd-igw"
 }

}
resource "aws_route_table" "docker-cicd-public-rt" {
    vpc_id = aws_vpc.docker-cicd-vpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.docker-cicd-igw.id
  }

  tags ={
  Name ="docker-cicd-public-rt"
  }
  
}
resource "aws_route_table_association" "rt-association-1"{
    route_table_id = aws_route_table.docker-cicd-public-rt.id
    subnet_id = aws_subnet.docker-cicd-public-1.id

  
}
resource "aws_route_table_association" "rt-association-2"{
    route_table_id = aws_route_table.docker-cicd-public-rt.id
    subnet_id = aws_subnet.docker-cicd-public-2.id

  
}
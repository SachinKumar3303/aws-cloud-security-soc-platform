terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_vpc" "soc_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "SOC-VPC"
    Project = "AWS-Cloud-Security-SOC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.soc_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "SOC-Public-Subnet"
    Project = "AWS-Cloud-Security-SOC"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.soc_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name    = "SOC-Private-Subnet"
    Project = "AWS-Cloud-Security-SOC"
  }
}

resource "aws_internet_gateway" "soc_igw" {
  vpc_id = aws_vpc.soc_vpc.id

  tags = {
    Name    = "SOC-Internet-Gateway"
    Project = "AWS-Cloud-Security-SOC"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.soc_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.soc_igw.id
  }

  tags = {
    Name    = "SOC-Public-Route-Table"
    Project = "AWS-Cloud-Security-SOC"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
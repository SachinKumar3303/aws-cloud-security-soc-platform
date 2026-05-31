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
resource "aws_security_group" "soc_public_sg" {
  name        = "SOC-Public-SG"
  description = "Security group for public servers"
  vpc_id      = aws_vpc.soc_vpc.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SOC-Public-SG"
  }
}
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
resource "aws_instance" "soc_server" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.soc_public_sg.id]

  key_name             = "soc-keypair"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name


  tags = {
    Name = "SOC-Server"
  }
}
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "SOC-EC2-CloudWatch-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "SOC-EC2-Profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}

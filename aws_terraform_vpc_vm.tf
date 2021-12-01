provider "aws" {
  profile = "default"
  region = "us-east-1"
}
resource "aws_default_vpc" "default" {}

resource "aws_security_group" "transformation" {
  name        = "transformation"
  description = "Allow standard http and https ports inbound and everything outbound"
  
  ingress {
    from_port  = 80
    to_port    = 80
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port  = 443
    to_port    = 443
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Terraform" : "true"    
  }
}

resource "aws_instance" "transformation" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.transformation.id
  ]

  tags = {
    "Terraform" = "true"
  }
}

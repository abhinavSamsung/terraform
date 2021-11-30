provider "aws" {
  profile = "default"
  region = "us-east-1"
}
resource "aws_default_vpc" "default" {}


resource "aws_instance" "transformation" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = "t3.micro"
}

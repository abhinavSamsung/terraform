provider "aws" {
  profile = "default"
  region = "us-east-1"
}
resource "aws_default_vpc" "default" {}

resource "aws_security_group" "transformation_new" {
  name        = "transformation_new"
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

resource "aws_instance" "NewServer" {
  ami           = var.ec2_image
  instance_type = var.ec2_instance_type
  count         = var.ec2_count
  tags = {
    Name = "Terraform-${count.index + 1}"
  }
}

resource "aws_launch_template" "NewServer" {
  name_prefix   = "foobar"
  image_id      = var.ec2_image
  instance_type = var.ec2_instance_type
}

output "instance_ip_addr" {
  value       = aws_instance.NewServer.*.private_ip
  description = "The private IP address of the main server instance."
}

output "instance_ips" {
  value = aws_instance.NewServer.*.public_ip
}

output "addresses" {
  value = aws_instance.NewServer.*.public_dns
}

# output "mac" {
#   value = aws_instance.NewServer.*.mac_address
# }

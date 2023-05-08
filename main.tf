terraform {
  cloud {
    organization = "kubayof"
    workspaces {
      name = "tf-instance"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.66.1"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "instance_sg" {
  name = "instance-sg"
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "-1"
  }

  egress {
    from_port = -1
    protocol  = "-1"
    to_port   = -1
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

#resource "aws_instance" "instance" {
#  tags = {
#    Name = "tf-instance"
#  }
#  ami = data.aws_ami.amazon_linux_2.id
#  instance_type = "t2.micro"
#  security_groups = [aws_security_group.instance_sg.id]
#  subnet_id = "subnet-07d3b96a2d1e16e3d"
#}

output "ami" {
  value = data.aws_ami.amazon_linux_2.name
}
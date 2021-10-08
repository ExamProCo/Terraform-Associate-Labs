terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.58.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
	alias = "east"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
	alias = "west"
}
data "aws_ami" "east-amazon-linux-2" {
	provider = aws.east
 	most_recent = true
	owners = ["amazon"]
	filter {
		name   = "owner-alias"
		values = ["amazon"]
	}
	filter {
		name   = "name"
		values = ["amzn2-ami-hvm*"]
	}
}

data "aws_ami" "west-amazon-linux-2" {
	provider = aws.west
 	most_recent = true
	owners = ["amazon"]
	filter {
		name   = "owner-alias"
		values = ["amazon"]
	}
	filter {
		name   = "name"
		values = ["amzn2-ami-hvm*"]
	}
}

resource "aws_instance" "my_east_server" {
  ami           = "${data.aws_ami.east-amazon-linux-2.id}"
  instance_type = "t2.micro"
	provider = aws.east
	tags = {
		Name = "Server-East"
	}
}

resource "aws_instance" "my_west_server" {
  ami           = "${data.aws_ami.west-amazon-linux-2.id}"
  instance_type = "t2.micro"
	provider = aws.west
	tags = {
		Name = "Server-West"
	}
}

output "east_public_ip" {
  value = aws_instance.my_east_server.public_ip
}
output "west_public_ip" {
  value = aws_instance.my_west_server.public_ip
}
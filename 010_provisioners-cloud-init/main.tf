terraform {
	/*
  backend "remote" {
    organization = "ExamPro"

    workspaces {
      name = "provisioners"
    }
  }
	*/
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "main" {
  id = "vpc-bd9bdcc7"
}


resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "MyServer Security Group"
  vpc_id      = data.aws_vpc.main.id

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
			prefix_list_ids  = []
			security_groups = []
			self = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["104.194.51.113/32"]
      ipv6_cidr_blocks = []
			prefix_list_ids  = []
			security_groups = []
			self = false
    }
  ]

  egress = [
    {
			description = "outgoing traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
			prefix_list_ids  = []
			security_groups = []
			self = false
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdgyskPBKxTa4G8rIT76MP1zKfL4Xv9UBn/k/p7bEQYLPzhGQfdki3em2Hnh/wGzjeRJsRCCgezMnyirOizm3jXbob5F9QVBGbwn0cQMu1CW9Dx59ce+vJQtz9ezCAocko7W8oij3fr0npJWVQchxiR+yI5lm1PexaESYTTmz/ImzmeF2AJNRDqKR4xFrK9kM22GOm2kd7YYXIxpqDOMZ7j7v1HHU9v9CwgHCGbq0c09EshCXLx0GZ7r3BjRun8vQ9OxgVGIf62MQAUbMPKR0oq84X5oVv/2a4d79Bx46Ttj1xlzP8UHgWrUKHUbpFZ6AZEMMIsLOzoduLk8eCzNvPWH/SkaEoc2ww+7+Ii0fDyeycTHzewQtXxyyzNDyFrZj8b08c+Pg1h26PClMNajUF4eBO8+u4ZbcvsDMdXKimvYeRXXaFMciy6NcMCq0ZwtwvmLsId+pm9Gu1WS/QG3JmRYUSMzc1FPZG9DI2aI3ivG3HQEuYe25hhik6adw24lk= root@DESKTOP-J1KCQ03"
}

data "template_file" "user_data" {
	template = file("./userdata.yaml")
}


resource "aws_instance" "my_server" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
	key_name = "${aws_key_pair.deployer.key_name}"
	vpc_security_group_ids = [aws_security_group.sg_my_server.id]
	user_data = data.template_file.user_data.rendered
  provisioner "file" {
    content     = "mars"
    destination = "/home/ec2-user/barsoon.txt"
		connection {
			type     = "ssh"
			user     = "ec2-user"
			host     = "${self.public_ip}"
			private_key = "${file("/root/.ssh/terraform")}"
		}
  }

  tags = {
    Name = "MyServer"
  }
}

output "public_ip"{
	value = aws_instance.my_server.public_ip
}
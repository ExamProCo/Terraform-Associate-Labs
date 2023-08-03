terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "main" {
  id = "vpc-c3be22b9"
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
      cidr_blocks      = ["174.5.116.22/32"]
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYEYsmIn73rDKorEofqKWf6deW69msWWoKZdh9h+VOhagT9PS1KCNPp7Nyogj1b+6I6SohZwu7GqSDBChCKI72scGXljFNYNrjpE4oy/K4UHqDTIYWJ+c4GSxr6Qul8i68nb31F0pOb/pknN0mztWrZIhDOpjrxmPZ5ibNvBrm1trvSWyNy4+cZXXaZjtko4dcoyj/38N+GWjGu2ZnkYzfYB3cFV2x+TGiX3EDm7KHd8AA3CpBDsaSXg1OZ456OA6jW5bBRcSHeAaN6YAiLlzj1WbI6yS3KrVL7HafNBovCv2mGYMOqCkGshiLDbOpi0LmAYqYA4VAkvPeLlWtttPXjDNXQZ1wroZVb32fPOpBZfJ2pU2xsj+DDq79Y/FbU87kViz24fen+ah/WkBaZJl+veX741gkwplNQw6/edWPqse0xH6Rga+a6ZHuIJl+2HnXb3EeZSCz3VBFCZHk00FdUBsfLB7kXKbT6ujodIBcCaH3uw+lPfyN3xdrv5ZFep8= andrew@DESKTOP-1LHO517"
}

data "template_file" "user_data" {
	template = file("./userdata.yaml")
}


resource "aws_instance" "my_server" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t3.micro"
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
			private_key = "${file("/home/andrew/.ssh/terraform")}"
		}
  }



  tags = {
    Name = "MyServer"
  }
}

resource "terraform_data" "status" {
	provisioner "local-exec" {
		command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.my_server.id}"
	}
	depends_on = [
		aws_instance.my_server
		]
}

output "public_ip"{
	value = aws_instance.my_server.public_ip
}
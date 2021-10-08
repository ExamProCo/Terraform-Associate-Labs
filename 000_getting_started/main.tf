terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "ExamPro"

    workspaces {
      name = "getting-started"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.58.0"
    }
  }
}

locals {
  project_name = "Andrew"
}
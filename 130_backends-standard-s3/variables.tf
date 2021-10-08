variable "bucket" {
	type = string
	default = "320489324827429471210198"
}

variable "vpc_id" {
	type = string
}

variable "my_ip_with_cidr" {
	type = string
}

variable "public_key" {
	type = string
}

variable "instance_type" {
	type = string
}

variable "server_name" {
	type = string
}

variable "workspace_iam_roles" {
  default = {
    staging    = "arn:aws:iam::STAGING-ACCOUNT-ID:role/Terraform"
    production = "arn:aws:iam::PRODUCTION-ACCOUNT-ID:role/Terraform"
  }
}
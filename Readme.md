## Install

[Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform) following the offical instructions

[Install HashiCorp Terraform VSCode Instructions](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)

We'll mostly be using AWS as the primary provider. 
If you want to follow along for all labs you'll need accounts for:

- [Amazon Web Services (AWS)](https://aws.amazon.com/)
- [Microsoft Azure](https://azure.microsoft.com)
- [Google Cloud Platform (GCP)](https://cloud.google.com)
- [Spotify](https://spotify.com)
- [Minecraft Licence](https://www.minecraft.net/en-us)

AWS CLI
Azure CLI
Google Cloud SDK

## Getting Started

We are going to learn the basics of Terraform:
- Creating main.tf
- Add AWS Provider
- Generate and configure AWS credentials
- Configure an AWS Virtual Machine
- Initialize terraform project
- Terraform fmt
- Terraform validate
- Terraform plan
- Terraform apply
- Terraform apply (updateing)
- Create Input Variables
- Set Locals
- Create Outputs
- Use a Terraform Module
- Divide project into multiple files
- Terraform destroy
- Create a Terraform Cloud workspace
- Migrate local to remote workspace
- Move AWS Credentials to Env Vars

## Provisioners

- Cloud-Init
- Local Exec
- Remote Exec
- File
- Connection
- Null Resource and Trigger

## Providers

- Provision AWS Resource
- Provision Azure Resource
- Provision GCP Resource

- Provision Spotify Playlist
- Provision Minecraft Server


## Terraform Registry


## Variables and Outputs

- terraform.tfvars
- additional variable files and -var-file
- additional autoloaded files
- -var
- TF_VAR_
- Ouputs CLI
- Chaining outputs from a module
- Local values
- Data Sources

## Resource Meta Arguements

- depends_on
- count
- for_each
- provider and alias
- lifecycle

## Expressions

- String Templates
- For Expressions
- Splats
- Dynamic Blocks
- Versions Constraints

## Terraform State
- terraform state list
- terraform state mv
- terraform state show
- terraform state mv

## Plan and Apply

- Speculative Plans
- Saved Plans

## Manage Resource Drift

- Replace
- Import
- Refresh

## Troubleshooting

- Terraform Log
- Terraform Crash log

## Modules

- Create a module
- Publish a module

## Terraform Workflows

- individual Terraform Workflow

## Backends

- Standard Backend with Amazon S3
- Remote backend multiple workspaces
- terraform_remote_state local
- terraform_remote_state remote
- force-unlock

## Resources

- collection types
- structual typeear

## Functions

- Built In Functions

## Terraform CLoud

- Terraform CLoud Permissions
- Terraform Cloud API Token
- Private Registry

## Workspaces

- Multiple workspaces Terraform Cloud

# Sentinel

- Sentinel Mocks
- Policy Set

# Vault

Vault with Terraform

# Packer

Packer with Terraform

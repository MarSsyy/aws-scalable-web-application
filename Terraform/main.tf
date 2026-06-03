terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["assignment-1-vpc-vpc"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_ami" "web_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["assignment-1-web-ami"]
  }
  owners = ["self"] 
}

data "aws_security_group" "web_app_sg" {
  filter {
    name   = "group-name"
    values = ["web-app-sg"]
  }
}

data "aws_security_group" "alb_sg" {
  filter {
    name   = "group-name"
    values = ["alb-sg"]
  }
}

data "aws_lb_target_group" "web_tg" {
  name = "assignment-1-tg"
}

data "aws_iam_instance_profile" "cw_role" {
  name = "LabInstanceProfile"
}
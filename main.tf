
locals {
  Staging_Environment = "staging"
}



resource "aws_vpc" "staging_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${local.Staging_Environment}-vpc-tag"
    }
  
}


resource "aws_subnet" "staging-subnet" {
    vpc_id = aws_vpc.staging_vpc.id
    cidr_block = "10.0.0.0/19"

    tags = {
        Name = "${local.Staging_Environment}-subnet"
    }
  
}

resource "aws_instance" "ec2_example" {
    ami = "ami-008616ec4a2c6975e"
    instance_type = "t3.nano"
    subnet_id = aws_subnet.staging-subnet.id
    tags = {
      Name = "${local.Staging_Environment}-Terraform-Ec2"
    }
}

resource "aws_iam_user" "users" {
  for_each = var.username
  name = each.value
}
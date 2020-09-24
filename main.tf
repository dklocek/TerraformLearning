provider "aws" {
  region = "eu-west-1"
  shared_credentials_file = "/var/creds/.credentials"
}

#-------------VPC---------------

resource "aws_vpc" "MyVpc" {
  tags = {
    name = "MyVPC"
  }
  cidr_block = var.vpc_cidr_block
}

#------------INTERNET--------------

resource "aws_internet_gateway" "InternetGateway" {
  vpc_id = aws_vpc.MyVpc.id
  tags = {
    name = "Terraform IG"
  }
}

resource "aws_subnet" "InternetSubnet" {
  cidr_block = var.InternetSubnet_cidr_block
  availability_zone = var.InternetSubnet_AZ
  vpc_id = aws_vpc.MyVpc.id
  tags = {
    name = "Terraform IntSubnet"
  }
}

resource "aws_route_table" "InternetTable" {
  vpc_id = aws_vpc.MyVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.InternetGateway.id
  }
  tags = {
    name = "Terraform IntRT"
  }
}

resource "aws_route_table_association" "InternetAssociation" {
  route_table_id = aws_route_table.InternetTable.id
  subnet_id = aws_subnet.InternetSubnet.id
}

#------------------NAT----------------

resource "aws_eip" "NatElasticIP" {
  tags = {
    name = "Terraform NatIP"
  }
}

resource "aws_nat_gateway" "NatGateway" {
  allocation_id = aws_eip.NatElasticIP.id
  subnet_id = aws_subnet.InternetSubnet.id
  tags = {
    name = "Terraform NatGateway"
  }
}

resource "aws_subnet" "NatSubnet" {
  cidr_block = var.NatSubnet_cidr_block
  availability_zone = var.NatSubnet_AZ
  vpc_id = aws_vpc.MyVpc.id
  tags = {
    name = "Terraform NatSubnet"
  }
}

resource "aws_route_table" "NatTable" {
  vpc_id = aws_vpc.MyVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NatGateway.id
  }
  tags = {
    name = "Terraform NAT RT"
  }
}

resource "aws_route_table_association" "NatAssociation" {
  route_table_id = aws_route_table.NatTable.id
  subnet_id = aws_subnet.NatSubnet.id
}

#------------POLICY FOR EC2 Read-Write S3 Bucket-----------
resource "aws_iam_policy" "S3RW_Policy" {
  name = "S3RW_Policy_Terraform"
  policy = <<EOF
{
  "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
          ],
        "Resource": "*"
        }
        ]
}
  EOF

}
resource "aws_iam_role_policy_attachment" "Attach" {
  policy_arn = aws_iam_policy.S3RW_Policy.arn
  role = aws_iam_role.S3RW_Role.name
}
resource "aws_iam_role" "S3RW_Role" {
  name = "S3RW_Role"
  assume_role_policy = <<-EOF
  {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Principal": {
                                "Service": [
                                    "ec2.amazonaws.com"
                                ]
                            },
                            "Action": [
                                "sts:AssumeRole"
                            ]
                        }
                    ]
                }
  EOF

}

resource "aws_iam_instance_profile" "InstanceProfile" {
  name = "S3RW_Instance_Profile"
  role = aws_iam_role.S3RW_Role.name

}

#------------Create S3 Bucket in Private--------
resource "aws_s3_bucket" "S3_Bucket" {
  acl = "private"
  tags = {
    name = "Terraform S3 Bucket"
  }
}
#--------------Security Group-------------------
resource "aws_security_group" "Security_Group" {
  vpc_id = aws_vpc.MyVpc.id
  description = "Terraform Group"
  name = "TFSecurityGroup"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags = {
    name = "Terraform_SG"
  }
}
data "template_file" "userdata" {
  template = file("userdata.tpl")
  vars = {
    bucket_name = aws_s3_bucket.S3_Bucket.id
  }
}
#----------INSTANCE------------------
resource "aws_instance" "TerraformInstance" {
  ami = var.ami
  instance_type = "t2.micro"
  security_groups = [
    aws_security_group.Security_Group.id]
  subnet_id = aws_subnet.NatSubnet.id
  key_name = "MainKeys"
  iam_instance_profile = aws_iam_instance_profile.InstanceProfile.name
  user_data = data.template_file.userdata.rendered
  tags = {
    name = "TerraformInstance"
  }
}







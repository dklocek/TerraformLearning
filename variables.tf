variable "vpc_cidr_block" {
  type = string
  description = "VPC CIDR_BLOCK"
  default = "10.0.0.0/16"
}

variable "InternetSubnet_cidr_block" {
  type = string
  description = "Internet Subnet CIDR_BLOCK"
  default = "10.0.0.0/24"
}

variable "NatSubnet_cidr_block" {
  type = string
  description = "Nat Subnet CIDR_BLOCK"
  default = "10.0.1.0/24"
}

variable "InternetSubnet_AZ" {
  type = string
  description = "Internet Subnet availability zone"
  default = "eu-west-1a"
}

variable "NatSubnet_AZ" {
  type = string
  description = "Internet Subnet availability zone"
  default = "eu-west-1b"
}

variable "ami" {
  type = string
  description = "AMI ID"
  default = "ami-08a2aed6e0a6f9c7d"
}
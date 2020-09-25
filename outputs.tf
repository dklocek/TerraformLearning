output "VPC_ID" {
  value = aws_vpc.MyVpc.id
}

output "S3_Bucket_name" {
  value = aws_s3_bucket.S3_Bucket.id
}

output "EC2_INSTANCE_ID" {
  value = aws_instance.TerraformInstance.id
}

output "EC2_INSTANCE_SUBNET" {
  value = aws_instance.TerraformInstance.subnet_id
}

output "AWS_INTERNET_SUBNET_ID" {
  value = aws_subnet.InternetSubnet.id
}

output "AWS_NAT_SUBNET_ID" {
  value = aws_subnet.NatSubnet.id
}
output "VPC_ID" {
  value = aws_vpc.MyVpc.id
}

output "S3_Bucket_name" {
  value = aws_s3_bucket.S3_Bucket.id
}

output "EC2_INSTANCE_ID" {
  value = aws_instance.TerraformInstance.id
}

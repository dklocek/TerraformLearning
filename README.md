<h1>Terraform Learning</h1>

This terraform project creates a infrastructure:

- VPC with <i>10.0.0.0/16</i> CIDR block
- Subnet with a Internet Gateway and Route Table
- Subnet with NAT Gateway and Route Table
- Elastic IP for NAT Gateway
- Role and Policy for R/W in AWS S3 attached to EC2 Instance
- Creates a S3 Bucket with ACL set to private
- Security Group (allows SSH from any IP - Please change it for real use)
- EC2 Instance with UserData set (write instance ID to a file in created S3 Bucket)

Main usage is na EC2 instance without Public IP, that can connect to the Internet for tasks and updates
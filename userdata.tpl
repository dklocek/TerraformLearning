#!/bin/bash
curl 169.254.169.254/latest/meta-data/instance-id > /home/ec2-user/InstanceId.txt
aws s3 cp /home/ec2-user/InstanceId.txt s3://"${bucket_name}"/InstanceId.txt
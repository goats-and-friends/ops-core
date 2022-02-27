#!/bin/sh

set -e
set -x

aws cloudformation create-stack --region ${TF_BACKUP_REGION} --stack-name terraform-state-replication-bucket --template-body file://state-backend-s3-replication.yml --capabilities CAPABILITY_IAM
aws cloudformation create-stack --region ${TF_REGION} --stack-name terraform-state-backend --template-body file://state-backend-s3.yml --capabilities CAPABILITY_IAM --parameters "ParameterKey=ReplicationBucketRegion,ParameterValue=${TF_BACKUP_REGION}"

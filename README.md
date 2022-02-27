# ops-core

## Bootstrap Terraform S3 State

It is a best practice not to have Terraform manage resources for its own state,
so we bootstrap with CloudFormation. Set up AWS CLI and run:

```bash
pushd bootstrap/
export TF_BACKUP_REGION=us-east-2
export TF_REGION=us-east-1
./bootstrap.sh
popd
```

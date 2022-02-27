# ops-core

## Setup

These instructions are intended to be run once using an administrative user
on a fresh AWS account. Set up your local `aws` CLI before getting started.

### Bootstrap Terraform S3 State

It is a best practice not to have Terraform manage resources for its own state,
so we bootstrap with CloudFormation. Set up AWS CLI and run:

```bash
pushd bootstrap/
export TF_BACKUP_REGION=us-east-2
export TF_REGION=us-east-1
./bootstrap.sh
popd
```

### Bootstrap GitHub Actions

GitHub Actions will assume an IAM role for deployments via OIDC, and this step
sets up the OIDC Provider and trust policies.

```bash
# Example variables
export ENV=staging
export TF_VAR_aws_region=us-east-1

pushd environments/$ENV
terraform init \
  -backend-config="bucket=tf-state-bucket-$(aws sts get-caller-identity --query Account --output=text)-$TF_VAR_aws_region" \
  -backend-config="region=$TF_VAR_aws_region" -reconfigure
terraform plan -out tfplan

# Inspect the plan. If it looks good, continue
terraform apply tfplan

# Hack: reconcile state drift
terraform apply -refresh-only

popd
```

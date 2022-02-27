module "aws_github_oidc" {
  source  = "unfunco/oidc-github/aws"
  version = "0.4.0"

  # TODO: least privilege IAM policy
  # TODO: filter subject claim to correct environment
  attach_admin_policy = true
  github_organisation = "goats-and-friends"
  github_repositories = [
    "ops-core",  # DO NOT REMOVE
    "ops-factorio",
  ]
}

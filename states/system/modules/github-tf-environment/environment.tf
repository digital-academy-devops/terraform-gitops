resource "github_repository_environment" "env" {
  environment = var.environment
  repository  = var.repository

  reviewers {
    users = var.reviewers
  }

  # custom branch rules cannot be configured via tf provider and have to be manually set
  deployment_branch_policy {
    protected_branches     = var.protected_branches
    custom_branch_policies = ! var.protected_branches
  }
}

resource "github_actions_environment_secret" "secret" {
  for_each        = var.secrets
  repository      = var.repository
  environment     = var.environment
  secret_name     = each.key
  plaintext_value = each.value
}
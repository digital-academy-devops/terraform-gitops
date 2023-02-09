resource "github_repository_environment" "env" {
  environment  = var.environment
  repository   = var.repository

  reviewers {
    users = var.reviewers
  }
}

resource "github_actions_environment_secret" "secret" {
  for_each = var.secrets
  repository       = var.repository
  environment = var.environment
  secret_name      = each.key
  plaintext_value  = each.value
}
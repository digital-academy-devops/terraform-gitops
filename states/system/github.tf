data "github_repository" "terraform-gitops" {
  full_name = "mostashkin/terraform-gitops"
}

data "github_user" "admin" {
  username = "mostashkin"
}

module "plan_env" {
  source             = "./modules/github-tf-environment"
  environment        = "plan"
  protected_branches = false
  repository         = data.github_repository.terraform-gitops.name
  secrets = {
    AWS_ACCESS_KEY_ID     = module.terraform-viewer-sa.static-key
    AWS_SECRET_ACCESS_KEY = module.terraform-viewer-sa.static-key-secret
    SA_KEY                = module.terraform-viewer-sa.key-json
  }
}

module "apply_env" {
  source      = "./modules/github-tf-environment"
  environment = "apply"
  repository  = data.github_repository.terraform-gitops.name
  reviewers = [
    data.github_user.admin.id,
  ]
  secrets = {
    AWS_ACCESS_KEY_ID     = module.terraform-sa.static-key
    AWS_SECRET_ACCESS_KEY = module.terraform-sa.static-key-secret
    SA_KEY                = module.terraform-sa.key-json
  }
}


resource "github_branch_protection" "main" {
  repository_id = data.github_repository.terraform-gitops.id

  pattern          = "main"
  enforce_admins   = false
  allows_deletions = false
  allows_force_pushes = false
  required_linear_history = true
  require_conversation_resolution = true

  #required_status_checks {
  #  strict   = false
  #  contexts = ["terraform"]
  #}

  #required_pull_request_reviews {
  #  dismiss_stale_reviews  = true
  #  restrict_dismissals    = true
  #  pull_request_bypassers = [
  #    data.github_user.admin.node_id,
  #  ]
  #  require_code_owner_reviews = true
  #  require_last_push_approval = true
  #}

}

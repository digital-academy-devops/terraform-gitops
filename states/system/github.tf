data "github_repository" "terraform-gitops" {
  full_name = "digital-academy-devops/terraform-gitops"
}

data "github_user" "admin" {
  username = "digital-academy-devops"
}

data "github_user" "mostashkin" {
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
    data.github_user.mostashkin.id
  ]
  secrets = {
    AWS_ACCESS_KEY_ID     = module.terraform-sa.static-key
    AWS_SECRET_ACCESS_KEY = module.terraform-sa.static-key-secret
    SA_KEY                = module.terraform-sa.key-json
  }
}


resource "github_branch_protection" "main" {
  repository_id = data.github_repository.terraform-gitops.id

  pattern                         = "main"
  enforce_admins                  = false
  allows_deletions                = false
  allows_force_pushes             = false
  required_linear_history         = true
  require_conversation_resolution = true

  required_status_checks {
    strict   = true
    contexts = [
      "plan",
      "labels"
    ]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews  = true
    pull_request_bypassers = [
      data.github_user.admin.node_id,
    ]
    require_code_owner_reviews = true
  }

}

resource "github_issue_label" "destroy" {
  repository = data.github_repository.terraform-gitops.name
  name       = "destroy"
  color      = "f25e02"
}

resource "github_issue_label" "apply" {
  repository = data.github_repository.terraform-gitops.name
  name       = "apply"
  color      = "fbca04"
}

resource "github_issue_label" "hi-expiration-time" {
  repository = data.github_repository.terraform-gitops.name
  name       = "hi-expiration-time"
  color      = "d73a4a"
}

data "github_repository" "terraform-gitops" {
  full_name = "mostashkin/terraform-gitops"
}

data "github_user" "admin" {
  username = "mostashkin"
}

module "plan_env" {
  source = "./modules/github-tf-environment"
  environment = "plan"
  repository = data.github_repository.terraform-gitops.name
  secrets = {
    AWS_ACCESS_KEY_ID = module.terraform-viewer-sa.static-key
    AWS_SECRET_ACCESS_KEY = module.terraform-viewer-sa.static-key-secret
    SA_KEY = module.terraform-viewer-sa.key-json
  }
}

module "apply_env" {
  source = "./modules/github-tf-environment"
  environment = "apply"
  repository = data.github_repository.terraform-gitops.name
  reviewers = [
    data.github_user.admin.id,
  ]
  secrets = {
    AWS_ACCESS_KEY_ID = module.terraform-sa.static-key
    AWS_SECRET_ACCESS_KEY = module.terraform-sa.static-key-secret
    SA_KEY = module.terraform-sa.key-json
  }
}


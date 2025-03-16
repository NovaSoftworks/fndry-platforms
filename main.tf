data "terraform_remote_state" "foundation" {
  backend = "gcs"
  config = {
    bucket = var.foundation_state_bucket
    prefix = "tfstate/foundation"
  }
}

output "foundation_outputs" {
  value = data.terraform_remote_state.foundation.outputs
}


module "poc_prd" {
  source = "./modules/platform"

  parent_folder_id       = data.terraform_remote_state.foundation.outputs.prd_platforms_folder_id
  billing_account_id     = var.billing_account
  environment_short_name = "prd"
  purpose                = "poc"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

# provider "databricks" {
#   alias      = "mws"
#   profile = "TF_SP"
#   # host       = "https://accounts.cloud.databricks.com"
#   # account_id = var.databricks_account_id

#   # client_id     = var.client_id
#   # client_secret = var.client_secret
# }

provider "databricks" {
  alias         = "mws"
  host          = "https://accounts.cloud.databricks.com"
  account_id    = var.databricks_account_id
  client_id     = var.client_id
  client_secret = var.client_secret
}

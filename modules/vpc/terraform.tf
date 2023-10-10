
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16.0"
    }
    databricks = {
      source                = "databricks/databricks"
      configuration_aliases = [databricks.mws]
    }
  }

  required_version = ">= 1.2.0"
}

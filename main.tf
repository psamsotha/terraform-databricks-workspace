

module "cross_account_iam_role" {
  source = "./modules/iam-role"
  providers = {
    databricks.mws = databricks.mws
  }
  databricks_account_id = var.databricks_account_id
  prefix                = local.prefix
  tags                  = var.tags
}

module "vpc" {
  source = "./modules/vpc"
  providers = {
    databricks.mws = databricks.mws
  }
  databricks_account_id = var.databricks_account_id
  cidr_block            = var.cidr_block
  prefix                = local.prefix
  tags                  = var.tags
}

module "root_bucket" {
  source = "./modules/root-bucket"
  providers = {
    databricks.mws = databricks.mws
  }
  databricks_account_id = var.databricks_account_id
  prefix                = local.prefix
  tags                  = var.tags
}

module "databricks_workspace" {
  source = "./modules/workspace"
  depends_on = [
    # module.cross_account_iam_role,
    # module.root_bucket,
    # module.vpc
  ]
  client_id             = var.client_id
  client_secret         = var.client_secret
  databricks_account_id = var.databricks_account_id
  prefix                = local.prefix
  region                = var.region

  admin_user_email       = var.admin_user_email
  root_bucket            = module.root_bucket.root_bucket_name
  cross_account_role_arn = module.cross_account_iam_role.cross_account_role_arn
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnet_ids
  security_group_ids     = [module.vpc.security_group_id]
}

module "unity_catalog" {
  source     = "./modules/unity-catalog"
  depends_on = [module.databricks_workspace]
  providers = {
    databricks.mws = databricks.mws
  }
  region       = var.region
  prefix       = local.prefix
  workspace_id = module.databricks_workspace.workspace_id
  root_bucket  = module.root_bucket.root_bucket_name
  metastore_id = var.metastore_id
}

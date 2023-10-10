
data "databricks_aws_assume_role_policy" "this" {
  external_id = var.databricks_account_id
}

resource "aws_iam_role" "cross_account_role" {
  name               = "${var.prefix}-crossaccount"
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  tags               = var.tags
}

# Due to a bug in the Terraform AWS provider (spotted in v3.28) the Databricks
# AWS cross-account policy creation and attachment to the IAM role takes longer
# than the AWS request confirmation to Terraform. As Terraform continues creating
# the Workspace, validation checks for the credentials are failing, as the policy
# doesn't get applied quick enough. 
#
# As a workaround give the aws_iam_role more time to be created with a time_sleep
# resource, which you need to add as a dependency to the databricks_mws_workspaces resource.
resource "time_sleep" "wait" {
  depends_on = [ aws_iam_role.cross_account_role ]
  create_duration = "20s"
}

data "databricks_aws_crossaccount_policy" "this" {
}

resource "aws_iam_role_policy" "this" {
  name   = "${var.prefix}-policy"
  role   = aws_iam_role.cross_account_role.id
  policy = data.databricks_aws_crossaccount_policy.this.json
}

resource "databricks_mws_credentials" "this" {
  provider         = databricks.mws
  account_id       = var.databricks_account_id
  role_arn         = aws_iam_role.cross_account_role.arn
  credentials_name = "${var.prefix}-creds"
  depends_on       = [ aws_iam_role_policy.this ]
}

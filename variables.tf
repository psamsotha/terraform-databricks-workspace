

variable "client_id" {}
variable "client_secret" {}
variable "databricks_account_id" {}
variable "metastore_id" {}
variable "admin_user_email" {}
# variable "sp_token" {}

variable "tags" {
  default = {}
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
  default = "us-west-2"
}

locals {
  prefix = "tf-db-demo"
}

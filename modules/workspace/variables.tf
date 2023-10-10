


variable "client_id" {}
variable "client_secret" {}
variable "databricks_account_id" {}

variable "cross_account_role_arn" {
  description = "ARN of cross-account role"
}

variable "prefix" {}

variable "region" {}

variable "root_bucket" {
  description = "Name of root bucket for storage configuration"
}

variable "security_group_ids" {
  description = "List of ID of security group for VPC"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for VPC"
  type        = list(string)
}

variable "admin_user_email" {
  description = "Email fo admin user"
  type = string
}

variable "vpc_id" {
  description = "ID of VPC"
}

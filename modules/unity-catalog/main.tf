
# resource "databricks_metastore" "this" {
#   name         = "${var.prefix}-metastore"
#   storage_root = "s3://${var.root_bucket}/metastore"
#   region       = var.region
# }

resource "databricks_metastore_assignment" "this" {
  # metastore_id = databricks_metastore.this.id
  metastore_id = var.metastore_id
  workspace_id = var.workspace_id
}

terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}
resource "local_file" "storage_module_file1" {
  filename = var.name
  content  = var.content
}
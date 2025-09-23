terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider "local" {}

resource "local_file" "example" {
  filename = "${path.module}/${var.file_name}"
  content = var.file_content
}

resource "local_file" "file2" {
  filename = "file2.txt"
  content = local_file.example.content
}

module "storage1" {
  source = "./modules/storage"
  name = "sm_file1.txt"
  content = "storage module file 1 content"
}

module "storage2" {
  source = "./modules/storage"
  name = "sm_file2.txt"
  content = "storage module file 2 content"
}


resource "local_file" "mf_output_file1" {
  filename = "mf_output_file1.txt"
  content = module.storage1.mf_output
}
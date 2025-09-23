output "mf_output" {
  value = local_file.storage_module_file1.filename
  description = "File path name"
}
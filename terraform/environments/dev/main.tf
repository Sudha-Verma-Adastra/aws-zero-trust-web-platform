module "ecr" {
  source = "git::https://github.com/Sudha-Verma-Adastra/terraform-aws-platform-modules.git//modules/ecr?ref=b476619812e7bdf688aedfa5b4d1f0547a70951a"

  repository_name         = var.repository_name
  image_tag_mutability    = "IMMUTABLE"
  scan_on_push            = true
  encryption_type         = "AES256"
  create_lifecycle_policy = true
  max_image_count         = var.max_image_count

  tags = {
    Component = "container-registry"
  }
}

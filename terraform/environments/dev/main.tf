module "ecr" {
  source = "git::https://github.com/Sudha-Verma-Adastra/terraform-aws-platform-modules.git//modules/ecr?ref=v1.0.0"

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

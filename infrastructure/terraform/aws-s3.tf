resource "aws_s3_bucket" "site" {
  bucket = "${local.organisation}-${local.system_code}"
  acl    = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Organisation = "${local.organisation}"
    SystemCode   = "${local.system_code}"
  }
}
data "aws_iam_policy_document" "site_bucket_policy" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.site.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

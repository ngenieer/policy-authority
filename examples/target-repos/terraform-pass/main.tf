# Minimal Terraform target expected to PASS under snapshot_v0.1 rules.
# Contains no public CIDRs, no wildcard IAM actions, and no explicit encryption disablement.

terraform {
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "private_bucket" {
  bucket = "policy-authority-pass-example"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

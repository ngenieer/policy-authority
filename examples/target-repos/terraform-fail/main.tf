# Terraform target intentionally FAILS under snapshot_v0.1:
# - Public ingress CIDR (0.0.0.0/0)
# - Wildcard IAM action
# - Encryption disabled

resource "aws_security_group" "open_sg" {
  name        = "open-sg"
  description = "Intentionally open for test"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_iam_policy_document" "bad_policy" {
  statement {
    actions   = ["*"]
    action    = "*"
    resources = ["*"]
  }
}

resource "aws_s3_bucket" "unencrypted" {
  bucket = "policy-authority-fail-example"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "unencrypted"
    enabled = true
  }

  # Explicitly disable encryption to trigger invariant failure
  encrypted = false
}

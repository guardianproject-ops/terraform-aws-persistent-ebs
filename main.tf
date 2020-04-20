module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace  = var.namespace
  name       = var.name
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = concat(var.attributes, [var.az])
  tags = merge(
    var.tags,
    {
      "AZ" = var.az
    },
  )
}

#################
# Data          #
#################
data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_kms_key" "default" {
  key_id = var.kms_key_id
}

data "aws_iam_policy_document" "attach_ebs" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "attach_ebs_policy" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [data.aws_kms_key.default.arn]
  }
  statement {
    effect = "Allow"

    actions = [
      "ec2:AttachVolume",
      "ec2:DetachVolume",
    ]

    resources = [
      "arn:${data.aws_partition.current.partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/${aws_ebs_volume.main.id}",
      "arn:${data.aws_partition.current.partition}:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
    ]
  }
}

#################
# EC2 Resources #
#################
resource "aws_ebs_volume" "main" {
  availability_zone = var.az
  size              = var.size
  type              = var.volume_type
  encrypted         = var.encrypted
  kms_key_id        = var.kms_key_id
  snapshot_id       = var.snapshot_id
  tags              = module.label.tags
}


#################
# IAM Resources #
#################

resource "aws_iam_policy" "attach_ebs" {
  name        = "attach-ebs-${aws_ebs_volume.main.id}-${module.label.id}"
  path        = "/"
  description = "Allows attach/detach of EBS volume ${aws_ebs_volume.main.id}"
  policy      = data.aws_iam_policy_document.attach_ebs_policy.json
}


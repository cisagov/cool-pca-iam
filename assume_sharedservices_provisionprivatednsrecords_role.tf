# IAM policy document that allows assumption of the
# ProvisionPrivateDNSRecords role in the Shared Services account
data "aws_iam_policy_document" "assume_sharedservices_provisionprivatednsrecords_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      data.terraform_remote_state.sharedservices_networking_production.outputs.provision_private_dns_records_role.arn,
      data.terraform_remote_state.sharedservices_networking_staging.outputs.provision_private_dns_records_role.arn,
    ]
  }
}

resource "aws_iam_policy" "assume_sharedservices_provisionprivatednsrecords_role" {
  description = var.assume_sharedservices_provisionprivatednsrecords_policy_description
  name        = var.assume_sharedservices_provisionprivatednsrecords_policy_name
  policy      = data.aws_iam_policy_document.assume_sharedservices_provisionprivatednsrecords_role_doc.json
}

# Attach the policy to the provisioners users group
resource "aws_iam_group_policy_attachment" "assume_sharedservices_provisionprivatednsrecords_role_attachment" {
  group      = aws_iam_group.provisioner_users.name
  policy_arn = aws_iam_policy.assume_sharedservices_provisionprivatednsrecords_role.arn
}

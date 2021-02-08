# IAM policy document that allows assumption of the ProvisionAccount role
# in each PCA account in var.pca_account_ids
data "aws_iam_policy_document" "assume_pca_provisionaccount_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [for account_id in var.pca_account_ids : format("arn:aws:iam::%s:role/%s", account_id, var.pca_provisionaccount_role_name)]
  }
}

resource "aws_iam_policy" "assume_pca_provisionaccount_role" {
  provider = aws.users

  description = var.assume_pca_provisionaccount_policy_description
  name        = var.assume_pca_provisionaccount_policy_name
  policy      = data.aws_iam_policy_document.assume_pca_provisionaccount_role_doc.json
}

# Attach the policy to the provisioners users group
resource "aws_iam_group_policy_attachment" "assume_pca_provisionaccount_role_attachment" {
  provider = aws.users

  group      = aws_iam_group.provisioner_users.name
  policy_arn = aws_iam_policy.assume_pca_provisionaccount_role.arn
}

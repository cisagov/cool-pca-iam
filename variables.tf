# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "pca_account_ids" {
  type        = list(string)
  description = "The list of PCA account IDs (e.g. [\"000000000000\", \"111111111111\"]).  Each account must contain a role that can be assumed to provision AWS resources in that account and that role must match the name in the pca_provisionaccount_role_name variable."
}

variable "users" {
  type        = map
  description = "A map containing the usernames of each PCA user, a list of roles assigned to that user, and a boolean flag (\"self_admin\") that specifies if the user is allowed to self-administer their security credentials.  The currently-supported roles are: [\"provisioner\"].  Example: { \"firstname1.lastname1\" = { \"roles\" = [ \"provisioner\" ], \"self_admin\" = true },  \"firstname2.lastname2\" = { \"roles\" = [ \"provisioner\" ], \"self_admin\" = false } }"
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assume_access_pca_terraform_backend_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows assumption of the role that allows access to PCA-related Terraform backend resources."
  default     = "Allow assumption of the AccessPCATerraformBackend role in the Terraform account."
}

variable "assume_access_pca_terraform_backend_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows assumption of the role that allows access to PCA-related Terraform backend resources."
  default     = "AssumeAccessPCATerraformBackend"
}

variable "assume_pca_provisionaccount_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows assumption of the role that allows access to provision all AWS resources in the PCA account(s)."
  default     = "Allow assumption of the ProvisionAccount role in the PCA account(s)."
}

variable "assume_pca_provisionaccount_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows assumption of the role that allows access to provision all AWS resources in the PCA account(s)."
  default     = "PCA-AssumeProvisionAccount"
}

variable "assume_sharedservices_provisionprivatednsrecords_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows assumption of the role that allows access to provision DNS records in private zones in the Shared Services account."
  default     = "Allow assumption of the ProvisionPrivateDNSRecords role in the Shared Services account."
}

variable "assume_sharedservices_provisionprivatednsrecords_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows assumption of the role that allows access to provision DNS records in private zones in the Shared Services account."
  default     = "SharedServices-AssumeProvisionPrivateDNSRecords"
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the non-global resources are to be provisioned (e.g. \"us-east-1\")."
  default     = "us-east-1"
}

variable "pca_provisionaccount_role_name" {
  type        = string
  description = "The name of the IAM role that allows sufficient permissions to provision all AWS resources in the PCA account(s)."
  default     = "ProvisionAccount"
}

variable "provisioner_users_group_name" {
  type        = string
  description = "The name of the group to be created for provisioner users."
  default     = "pca_provisioners"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}

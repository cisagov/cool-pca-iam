# cool-users-pca #

[![GitHub Build Status](https://github.com/cisagov/cool-users-pca/workflows/build/badge.svg)](https://github.com/cisagov/cool-users-pca/actions)

This project is used to manage IAM user accounts and group membership related
to COOL PCA accounts and resources.

## Pre-Requisites ##

Before attempting to use this project, ensure that a Users account has been
created and contains a ProvisionAccount role (ideally created via the
[`cool-accounts`](https://github.com/cisagov/cool-accounts) repository).

Each PCA account specified in the `pca_account_ids` variable must also exist
and contain a ProvisionAccount role (ideally created via the
[`cool-accounts-pca`](https://github.com/cisagov/cool-accounts-pca) repository).

## Usage ##

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
   variables (see [Inputs](#Inputs) below for details):

   ```hcl
   pca_account_ids = [
     "000000000000",  # staging
     "111111111111",  # production
   ]

   users = {
     "first1.last1" = { "roles" = ["provisioner"], "self_admin" = true },
     "first2.last2" = { "roles" = ["provisioner"], "self_admin" = false },
   }
   ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
   -var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 3.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume_pca_provisionaccount_policy_description | The description to associate with the IAM policy that allows assumption of the role that allows access to provision all AWS resources in the PCA account(s). | `string` | `Allow assumption of the ProvisionAccount role in the PCA account(s).` | no |
| assume_pca_provisionaccount_policy_name | The name to assign the IAM policy that allows assumption of the role that allows access to provision all AWS resources in the PCA account(s). | `string` | `PCA-AssumeProvisionAccount` | no |
| aws_region | The AWS region where the non-global resources are to be provisioned (e.g. "us-east-1"). | `string` | `us-east-1` | no |
| pca_account_ids | The list of PCA account IDs (e.g. ["000000000000", "111111111111"]).  Each account must contain a role that can be assumed to provision AWS resources in that account and that role must match the name in the pca_provisionaccount_role_name variable. | `list(string)` | n/a | yes |
| pca_provisionaccount_role_name | The name of the IAM role that allows sufficient permissions to provision all AWS resources in the PCA account(s). | `string` | `ProvisionAccount` | no |
| provisioner_users_group_name | The name of the group to be created for provisioner users. | `string` | `pca_provisioners` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| users | A map containing the usernames of each PCA user, a list of roles assigned to that user, and a boolean flag ("self_admin") that specifies if the user is allowed to self-administer their security credentials.  The currently-supported roles are: ["provisioner"].  Example: { "firstname1.lastname1" = { "roles" = [ "provisioner" ], "self_admin" = true },  "firstname2.lastname2" = { "roles" = [ "provisioner" ], "self_admin" = false } } | `map` | n/a | yes |

## Outputs ##

No output.

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is just the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.

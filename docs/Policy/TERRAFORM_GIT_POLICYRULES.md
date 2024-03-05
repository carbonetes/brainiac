# Terraform GITHUB Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform GITHUB).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFGIT_001 | resource | github_repository | Verify that the GitHub repository has been configured as a private repository | checker/terraform/rules/git/github_repository_private.rego |
| CB_TFGIT_002 | resource | github_repository_webhook | Verify that GitHub repository webhooks are configured to use the HTTPS protocol | checker/terraform/rules/git/github_repository_webhook_https.rego |
| CB_TFGIT_003 | resource | github_repository | Verify that GitHub repositories have vulnerability alerts activated | checker/terraform/rules/git/github_repository_vuln_alerts_enabled.rego |
| CB_TFGIT_004 | resource | github_actions_environment_secret | Verify that the GitHub Actions secrets are securely encrypted | checker/terraform/rules/git/github_actions_environment_secret_actions_secret_encrypted.rego |
| CB_TFGIT_004 | resource | github_actions_organization_secret | Verify that the GitHub Actions secrets are securely encrypted | checker/terraform/rules/git/github_actions_environment_secret_actions_secret_encrypted.rego |
| CB_TFGIT_004 | resource | github_actions_secret | Verify that the GitHub Actions secrets are securely encrypted | checker/terraform/rules/git/github_actions_environment_secret_actions_secret_encrypted.rego |
| CB_TFGIT_005 | resource | github_branch_protection | GitHub pull requests must have a minimum of two approvals | checker/terraform/rules/git/github_branch_protection_pr_approvals.rego |
| CB_TFGIT_005 | resource | github_branch_protection_v3 | GitHub pull requests must have a minimum of two approvals | checker/terraform/rules/git/github_branch_protection_pr_approvals.rego |
| CB_TFGIT_006 | resource | github_branch_protection | Verify GitHub branch protection rules mandate the use of signed commits | checker/terraform/rules/git/github_branch_protection_rules_signed_commits.rego |
| CB_TFGIT_006 | resource | 
github_branch_protection_v3 | Verify GitHub branch protection rules mandate the use of signed commits | checker/terraform/rules/git/github_branch_protection_rules_signed_commits.rego |
| CB_TFGIT_007 | resource | github_repository | Verify that every repository is linked with branch protection | checker/terraform/rules/git/github_repository_branch_protection.rego |
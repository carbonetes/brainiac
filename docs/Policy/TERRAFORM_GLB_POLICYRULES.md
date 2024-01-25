# Terraform GITLAB Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform GITLAB).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TGLB_001 | resource | gitlab_project | Verify that a GitLab merge request mandates a minimum of two approving reviews for the merge process | checker/terraform/rules/glb/gitlab_project_two_approved_reviews.rego |
| CB_TGLB_002 | resource | gitlab_branch_protection | Prevent force pushes in GitLab branch protection rules | checker/terraform/rules/glb/gitlab_branch_protection_force_pushes_restricted.rego |
| CB_TGLB_003 | resource | gitlab_project | Verify that GitLab's prevention of secrets feature is activated | checker/terraform/rules/glb/gitlab_project_prevent_secrets.rego |
| CB_TGLB_004 | resource | gitlab_project | Verify that GitLab commits are digitally signed | checker/terraform/rules/glb/gitlab_project_commits_signed.rego |
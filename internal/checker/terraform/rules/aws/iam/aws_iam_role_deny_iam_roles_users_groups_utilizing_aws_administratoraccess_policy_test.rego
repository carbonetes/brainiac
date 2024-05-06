package lib.terraform.CB_TFAWS_250

import rego.v1

test_aws_iam_role_deny_iam_roles_users_groups_utilizing_aws_administratoraccess_policy_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_iam_role",
			"example",
		],
		"Attributes": {
			"managed_policy_arns": ["arn:aws:iam::aws:policy/SomeOtherPolicy"],
			"policy_arn": "arn:aws:iam::aws:policy/AdministratorAccess",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_iam_role_deny_iam_roles_users_groups_utilizing_aws_administratoraccess_policy_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_iam_role",
			"example",
		],
		"Attributes": {
			"managed_policy_arns": ["arn:aws:iam::aws:policy/AdministratorAccess"],
			"policy_arn": "arn:aws:iam::aws:policy/AdministratorAccess",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

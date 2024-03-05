package lib.terraform.CB_TFGLB_002

test_gitlab_branch_protection_force_pushes_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"gitlab_branch_protection",
			"BranchProtect",
		],
		"Attributes": {"allow_force_push": false},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_gitlab_branch_protection_force_pushes_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"gitlab_branch_protection",
			"BranchProtect",
		],
		"Attributes": {"allow_force_push": true},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

package lib.terraform.CB_TFGIT_006

test_github_branch_protection_rules_signed_commits_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"github_branch_protection_v3",
			"example",
		],
		"Attributes": {"require_signed_commits": true},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_github_branch_protection_rules_signed_commits_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"github_branch_protection_v3",
			"example",
		],
		"Attributes": {"require_signed_commits": false},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

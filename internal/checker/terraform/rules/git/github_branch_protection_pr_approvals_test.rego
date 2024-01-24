package lib.terraform.CB_TFGIT_005

test_github_repository_private_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"github_branch_protection_v3",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "required_pull_request_reviews",
			"Labels": [],
			"Attributes": {"required_approving_review_count": "2"},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_github_repository_private_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"github_branch_protection_v3",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "required_pull_request_reviews",
			"Labels": [],
			"Attributes": {"required_approving_review_count": "1"},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

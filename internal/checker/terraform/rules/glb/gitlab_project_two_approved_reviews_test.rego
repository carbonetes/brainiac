package lib.terraform.CB_TFGLB_001

test_gitlab_project_two_approved_reviews_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"gitlab_project",
			"example",
		],
		"Attributes": {"approvals_before_merge": "2"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_gitlab_project_two_approved_reviews_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"gitlab_project",
			"example",
		],
		"Attributes": {"approvals_before_merge": "1"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

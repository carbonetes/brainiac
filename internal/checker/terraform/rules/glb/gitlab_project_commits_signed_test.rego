package lib.terraform.CB_TFGLB_004

test_gitlab_project_commits_signed_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"gitlab_project",
			"example-two",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "push_rules",
			"Labels": [],
			"Attributes": {"reject_unsigned_commits": true},
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

test_gitlab_project_commits_signed_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"gitlab_project",
			"example-two",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "push_rules",
			"Labels": [],
			"Attributes": {"reject_unsigned_commits": false},
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

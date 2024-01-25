package lib.terraform.CB_TFGLB_003

test_gitlab_project_prevent_secrets_passed {
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
			"Attributes": {"prevent_secrets": true},
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

test_gitlab_project_prevent_secrets_failed {
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
			"Attributes": {"prevent_secrets": false},
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

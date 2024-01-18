package lib.terraform.CB_TFGIT_001

test_github_repository_private_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"github_repository",
			"example_repo",
		],
		"Attributes": {
			"description": "An example repository",
			"name": "example-repo",
			"private": true,
			"visibility": "private",
		},
		"Blocks": [],
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
			"github_repository",
			"example_repo",
		],
		"Attributes": {
			"description": "An example repository",
			"name": "example-repo",
			"private": false,
			"visibility": "",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

package lib.terraform.CB_TFGIT_002

test_github_repository_webhook_https_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"github_repository_webhook",
			"foo",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "configuration",
			"Labels": [],
			"Attributes": {
				"insecure_ssl": false,
				"url": "https://google.com/",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_github_repository_webhook_https_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"github_repository_webhook",
			"foo",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "configuration",
			"Labels": [],
			"Attributes": {
				"insecure_ssl": true,
				"url": "https://google.com/",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

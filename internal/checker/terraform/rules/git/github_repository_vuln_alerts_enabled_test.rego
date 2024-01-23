package lib.terraform.CB_TFGIT_003

test_github_repository_vuln_alerts_enabled_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"github_repository",
			"example",
		],
		"Attributes": {"vulnerability_alerts": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_github_repository_vuln_alerts_enabled_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"github_repository",
			"example",
		],
		"Attributes": {"vulnerability_alerts": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

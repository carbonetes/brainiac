package lib.terraform.CB_TFGIT_004

test_github_actions_environment_secret_actions_secret_encrypted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"github_actions_environment_secret",
			"test_secret",
		],
		"Attributes": {"plaintext_value": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_github_actions_environment_secret_actions_secret_encrypted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"github_actions_environment_secret",
			"test_secret",
		],
		"Attributes": {"plaintext_value": "example%value"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

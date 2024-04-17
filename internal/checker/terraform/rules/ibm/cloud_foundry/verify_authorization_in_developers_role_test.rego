package lib.terraform.CB_TFIBM_044
import rego.v1

test_developer_email_assigned_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_space",
			"space",
		],
		"Attributes": {"developers": ["developers@carbonetes.com"]},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_developer_email_assigned_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_space",
			"space",
		],
		"Attributes": {"developers": []},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

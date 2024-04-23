package lib.terraform.CB_TFIBM_033
import rego.v1

test_manager_email_assigned_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_org",
			"testacc_org",
		],
		"Attributes": {"managers": ["managers@carbonetes.com"]},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_manager_email_assigned_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_org",
			"testacc_org",
		],
		"Attributes": {"managers": []},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

package lib.terraform.CB_TFIBM_034
import rego.v1

test_user_email_assigned_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_org",
			"testacc_org",
		],
		"Attributes": {"users": ["users@carbonetes.com"]},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_user_email_assigned_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_org",
			"testacc_org",
		],
		"Attributes": {"users": []},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

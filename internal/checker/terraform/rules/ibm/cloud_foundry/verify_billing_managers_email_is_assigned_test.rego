package lib.terraform.CB_TFIBM_032

import rego.v1

test_billing_manager_email_assigned_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_org",
			"testacc_org",
		],
		"Attributes": {"billing_managers": ["billing_managers@carbonetes.com"]},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_billing_manager_email_assigned_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_org",
			"testacc_org",
		],
		"Attributes": {"billing_managers": []},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

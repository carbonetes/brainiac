package lib.terraform.CB_TFIBM_028
import rego.v1

test_auditor_email_assigned_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_org",
			"testacc_org",
		],
		"Attributes": {"auditors": ["auditors@carbonetes.com"]},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_auditor_email_assigned_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_org",
			"testacc_org",
		],
		"Attributes": {"auditors": []},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

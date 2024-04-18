package lib.terraform.CB_TFIBM_020
import rego.v1

test_sensitive_data_exposed_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_app_domain_private",
			"domain",
		],
		"Attributes": {"org_guid": "data.ibm_org.orgdata.id"},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 5,
		},
	}]
	count(result) == 1
}

test_sensitive_data_exposed_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_app_domain_private",
			"domain",
		],
		"Attributes": {"org_guid": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 5,
		},
	}]
	count(result) == 1
}

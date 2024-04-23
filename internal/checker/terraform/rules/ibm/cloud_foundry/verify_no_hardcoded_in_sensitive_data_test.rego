package lib.terraform.CB_TFIBM_027
import rego.v1

test_no_hardcoded_sensitive_data_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_app_domain_shared",
			"domain",
		],
		"Attributes": {
			"name": "example.com",
			"router_group_guid": "groupGuid",
			"tags": [
				"tag1",
				"tag2",
			],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_no_hardcoded_sensitive_data_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_app_domain_shared",
			"domain",
		],
		"Attributes": {
			"name": "example.com",
			"router_group_guid": "//groupGuid//--",
			"tags": [
				"tag1",
				"tag2",
			],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

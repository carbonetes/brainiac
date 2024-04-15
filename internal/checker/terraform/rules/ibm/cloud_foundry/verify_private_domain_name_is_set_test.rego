package lib.terraform.CB_TFIBM_019
import rego.v1

test_private_domain_name_set_pass if {
	result := passed with input as [
		{
			"Type": "data",
			"Labels": [
				"ibm_org",
				"orgdata",
			],
			"Attributes": {"org": "example.com"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ibm_app_domain_private",
				"domain",
			],
			"Attributes": {
				"name": "private domain",
				"org_guid": "data.ibm_org.orgdata.id",
				"tags": [
					"tag1",
					"tag2",
				],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_private_domain_name_set_fail if {
	result := failed with input as [
		{
			"Type": "data",
			"Labels": [
				"ibm_org",
				"orgdata",
			],
			"Attributes": {"org": "example.com"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ibm_app_domain_private",
				"domain",
			],
			"Attributes": {
				"name": "",
				"org_guid": "data.ibm_org.orgdata.id",
				"tags": [
					"tag1",
					"tag2",
				],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

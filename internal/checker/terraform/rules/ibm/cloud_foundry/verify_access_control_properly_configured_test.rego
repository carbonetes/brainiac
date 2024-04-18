package lib.terraform.CB_TFIBM_011
import rego.v1

test_access_control_configured_pass if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_app",
			"app"
		],
		"Attributes": {
			"app_version": "1.0",
			"tags": [
				"tags1",
				"tags2"
			]
		},
		"Blocks": [],
		"line_range": {
			"endLine": 25,
			"startLine": 2
		}
}]
	count(result) == 1
}

test_access_control_configured_fail if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_app",
			"app"
		],
		"Attributes": {
			"app_version": "2.0",
			"tags": [
				""
			]
		},
		"Blocks": [],
		"line_range": {
			"endLine": 25,
			"startLine": 2
		}
}]
	count(result) == 1
}

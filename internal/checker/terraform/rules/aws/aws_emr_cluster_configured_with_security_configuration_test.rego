package lib.terraform.CB_TFAWS_365

import rego.v1 

test_aws_emr_cluster_configured_with_security_configuration_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_emr_cluster",
			"example",
		],
		"Attributes": {"security_configuration": "your_security_configuration_name"},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_emr_cluster_configured_with_security_configuration_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_emr_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

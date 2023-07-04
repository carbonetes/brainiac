package lib.terraform.CB_TFOCI_006

test_oci_core_instance_legacy_endpoint_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_instance",
			"pass",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "instance_options",
			"Labels": [],
			"Attributes": {"are_legacy_imds_endpoints_disabled": true},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_oci_core_instance_legacy_endpoint_not_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_instance",
			"pass",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "instance_options",
			"Labels": [],
			"Attributes": {"are_legacy_imds_endpoints_disabled": false},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

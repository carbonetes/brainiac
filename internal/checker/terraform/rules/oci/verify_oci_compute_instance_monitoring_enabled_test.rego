package lib.terraform.CB_TFOCI_007

test_oci_compute_instance_monitoring_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_instance",
			"pass",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "agent_config",
			"Labels": [],
			"Attributes": {"is_monitoring_disabled": false},
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

test_oci_compute_instance_monitoring_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_instance",
			"pass",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "agent_config",
			"Labels": [],
			"Attributes": {"is_monitoring_disabled": true},
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

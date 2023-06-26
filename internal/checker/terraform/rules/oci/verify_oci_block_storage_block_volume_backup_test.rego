package lib.terraform.CB_TFOCI_002

test_no_hardcoded_private_key {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_volume",
			"pass",
		],
		"Attributes": {
			"availability_domain": "var.volume_availability_domain",
			"backup_policy_id": "test",
			"compartment_id": "var.compartment_id",
		},
		"Blocks": [{
			"Type": "block_volume_replicas",
			"Labels": [],
			"Attributes": {"availability_domain": "var.volume_block_volume_replicas_availability_domain"},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 8,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_hardcoded_private_key {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_volume",
			"pass",
		],
		"Attributes": {
			"availability_domain": "var.volume_availability_domain",
			"compartment_id": "var.compartment_id",
		},
		"Blocks": [{
			"Type": "block_volume_replicas",
			"Labels": [],
			"Attributes": {"availability_domain": "var.volume_block_volume_replicas_availability_domain"},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 8,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

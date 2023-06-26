package lib.terraform.CB_TFOCI_005

test_noci_core_instance_transit_encryption_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_instance",
			"example",
		],
		"Attributes": {"is_pv_encryption_in_transit_enabled": true},
		"Blocks": [{
			"Type": "launch_options",
			"Labels": [],
			"Attributes": {
				"boot_volume_id": "oci_core_boot_volume.example.id",
				"is_pv_encryption_in_transit_enabled": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_noci_core_instance_transit_encryption_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_core_instance",
			"example",
		],
		"Attributes": {"is_pv_encryption_in_transit_enabled": true},
		"Blocks": [{
			"Type": "launch_options",
			"Labels": [],
			"Attributes": {
				"boot_volume_id": "oci_core_boot_volume.example.id",
				"is_pv_encryption_in_transit_enabled": false,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

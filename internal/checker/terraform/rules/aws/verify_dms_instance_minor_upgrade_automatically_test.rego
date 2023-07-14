package lib.terraform.CB_TFAWS_213

test_dms_instance_minor_upgrade_automatically {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_replication_instance",
			"example",
		],
		"Attributes": {"auto_minor_version_upgrade": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_dms_instance_minor_upgrade_automatically_false {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_dms_replication_instance",
			"example",
		],
		"Attributes": {"auto_minor_version_upgrade": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

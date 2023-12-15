package lib.terraform.CB_TFALI_030

test_alicloud_disk_cmk_encrypted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_disk",
			"pass",
		],
		"Attributes": {
			"category": "cloud_efficiency",
			"description": "Hello ecs disk.",
			"encrypted": true,
			"kms_key_id": "2a6767f0-a16c-1234-5678-13bf*****",
			"size": "30",
			"tags": {"Name": "TerraformTest"},
		},
		"Blocks": [],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_disk_cmk_encrypted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_disk",
			"pass",
		],
		"Attributes": {
			"category": "cloud_efficiency",
			"description": "Hello ecs disk.",
			"encrypted": false,
			"size": "30",
			"snapshot_id": "your_snapshot_id_here",
			"tags": {"Name": "TerraformTest"},
		},
		"Blocks": [],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

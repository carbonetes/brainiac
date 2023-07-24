package lib.terraform.CB_TFAWS_203

test_aws_ami_amis_encrypted_utilizing_kms_cmks_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ami",
			"example",
		],
		"Attributes": {
			"name": "example-ami",
			"virtualization_type": "hvm",
		},
		"Blocks": [{
			"Type": "ebs_block_device",
			"Labels": [],
			"Attributes": {
				"device_name": "/dev/sda1",
				"snapshot_id": "snapshot-id",
				"encrypted": true,
				"volume_size": "20",
				"volume_type": "gp2",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_ami_amis_encrypted_utilizing_kms_cmks_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ami",
			"example",
		],
		"Attributes": {
			"nmea": "example-ami",
			"virtualization_type": "hvm",
		},
		"Blocks": [{
			"Type": "ebs_block_device",
			"Labels": [],
			"Attributes": {
				"device_name": "/dev/sda1",
				"encrypted": false,
				"volume_size": "20",
				"volume_type": "gp2",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

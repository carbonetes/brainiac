package lib.terraform.CB_TFAWS_203
import rego.v1

test_aws_ami_amis_encrypted_utilizing_kms_cmks_passed if {
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
				"encrypted": true,
				"snapshot_id": "snapshot-id",
				"volume_size": "20",
				"volume_type": "gp2",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_ami_amis_encrypted_utilizing_kms_cmks_failed if {
	result := failed with input as [{
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
				"encrypted": false,
				"volume_size": "20",
				"volume_type": "gp2",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

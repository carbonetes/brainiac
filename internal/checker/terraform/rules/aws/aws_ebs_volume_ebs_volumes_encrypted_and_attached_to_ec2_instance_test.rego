package lib.terraform.CB_TFAWS_323

test_aws_ebs_volume_ebs_volumes_encrypted_and_attached_to_ec2_instance_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_instance",
				"web",
			],
			"Attributes": {
				"ami": "ami-21f78e11",
				"availability_zone": "us-west-2a",
				"instance_type": "t2.micro",
				"tags": {"Name": "HelloWorld"},
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_volume_attachment",
				"ok_attachment1",
			],
			"Attributes": {
				"device_name": "/dev/sdh3",
				"instance_id": "aws_instance.web.id",
				"volume_id": "aws_ebs_volume.ok_ebs2.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 15,
				"startLine": 11,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_ebs_volume",
				"ok_ebs2",
			],
			"Attributes": {
				"availability_zone": "",
				"encrypted": true,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 21,
				"startLine": 18,
			},
		},
	]

	count(result) == 1
}

test_aws_ebs_volume_ebs_volumes_encrypted_and_attached_to_ec2_instance_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_instance",
				"web",
			],
			"Attributes": {
				"ami": "ami-21f78e11",
				"availability_zone": "us-west-2a",
				"instance_type": "t2.micro",
				"tags": {"Name": "HelloWorld"},
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_volume_attachment",
				"ok_attachment1",
			],
			"Attributes": {
				"device_name": "/dev/sdh3",
				"instance_id": "aws_instance.web.id",
				"volume_id": "aws_ebs_volume.ok_ebs2.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 15,
				"startLine": 11,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_ebs_volume",
				"ok_ebs2",
			],
			"Attributes": {
				"availability_zone": "",
				"encrypted": false,
			},
			"Blocks": [],
			"line_range": {
				"endLine": 21,
				"startLine": 18,
			},
		},
	]
	count(result) == 1
}

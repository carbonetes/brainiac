package lib.terraform.CB_TFAWS_323

import rego.v1

test_aws_security_group_attached_to_another_resource_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_network_interface",
				"test",
			],
			"Attributes": {
				"security_groups": "aws_security_group.ok_sg.id",
				"subnet_id": "aws_subnet.public_a.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_instance",
				"test",
			],
			"Attributes": {
				"ami": "data.aws_ami.ubuntu.id",
				"instance_type": "t3.micro",
				"security_groups": "aws_security_group.ok_sg.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_security_group",
				"ok_sg",
			],
			"Attributes": {},
			"Blocks": [{
				"Type": "ingress",
				"Labels": [],
				"Attributes": {
					"cidr_blocks": ["0.0.0.0/0"],
					"description": "TLS from VPC",
					"from_port": "443",
					"protocol": "tcp",
					"to_port": "443",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 19,
					"startLine": 13,
				},
			}],
			"line_range": {
				"endLine": 20,
				"startLine": 12,
			},
		},
	]

	count(result) == 1
}

test_aws_security_group_attached_to_another_resource_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_network_interface",
				"test",
			],
			"Attributes": {
				"security_groups": "",
				"subnet_id": "aws_subnet.public_a.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_instance",
				"test",
			],
			"Attributes": {
				"ami": "data.aws_ami.ubuntu.id",
				"instance_type": "t3.micro",
				"security_groups": "",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_security_group",
				"ok_sg",
			],
			"Attributes": {},
			"Blocks": [{
				"Type": "ingress",
				"Labels": [],
				"Attributes": {
					"cidr_blocks": ["0.0.0.0/0"],
					"description": "TLS from VPC",
					"from_port": "443",
					"protocol": "tcp",
					"to_port": "443",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 19,
					"startLine": 13,
				},
			}],
			"line_range": {
				"endLine": 20,
				"startLine": 12,
			},
		},
	]
	count(result) == 1
}

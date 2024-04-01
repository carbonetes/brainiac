package lib.terraform.CB_TFAWS_352

import rego.v1 

test_aws_eip_eip_addresses_allocated_to_vpc_attached_to_ec2_instances_passed if {
	result := passed with input as [
		{
        "Type": "resource",
        "Labels": [
        "aws_eip",
        "ok_eip"
        ],
        "Attributes": {
        "instance": "aws_instance.ec2.id",
        "vpc": true
        },
        "Blocks": [],
        "line_range": {
        "endLine": 4,
        "startLine": 1
        }
        },
        {
        "Type": "resource",
        "Labels": [
        "aws_instance",
        "ec2"
        ],
        "Attributes": {
        "ami": "ami-21f78e11",
        "availability_zone": "us-west-2a",
        "instance_type": "t2.micro",
        "tags": {
            "Name": "HelloWorld"
        }
        },
        "Blocks": [],
        "line_range": {
        "endLine": 14,
        "startLine": 6
        }
        }
	]
	count(result) == 1
}

test_aws_eip_eip_addresses_allocated_to_vpc_attached_to_ec2_instances_failed if {
	result := failed with input as [
		{
        "Type": "resource",
        "Labels": [
        "aws_eip",
        "ok_eip"
        ],
        "Attributes": {
        "instance": "",
        "vpc": true
        },
        "Blocks": [],
        "line_range": {
        "endLine": 4,
        "startLine": 1
        }
        }
	]
	count(result) == 1
}

package lib.terraform.CB_TFAWS_329

import rego.v1 

test_aws_emr_cluster_ensure_security_groups_of_emr_clusters_are_not_open_to_the_world_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_emr_cluster",
				"cluster_ok",
			],
			"Attributes": {
				"applications": ["Spark"],
				"name": "emr-test-arn",
				"release_label": "emr-4.6.0",
			},
			"Blocks": [{
				"Type": "ec2_attributes",
				"Labels": [],
				"Attributes": {
					"emr_managed_master_security_group": "aws_security_group.block_access_ok.id",
					"emr_managed_slave_security_group": "aws_security_group.block_access_ok.id",
					"instance_profile": "connected_to_aws_iam_instance_profile",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_security_group",
				"block_access_ok",
			],
			"Attributes": {
				"description": "Block all traffic",
				"name": "block_access",
			},
			"Blocks": [
				{
					"Type": "ingress",
					"Labels": [],
					"Attributes": {
						"cidr_blocks": ["10.0.0.0/16"],
						"from_port": "0",
						"protocol": "-1",
						"to_port": "0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 22,
						"startLine": 17,
					},
				},
				{
					"Type": "egress",
					"Labels": [],
					"Attributes": {
						"cidr_blocks": ["10.0.0.0/16"],
						"from_port": "0",
						"protocol": "-1",
						"to_port": "0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 29,
						"startLine": 24,
					},
				},
			],
			"line_range": {
				"endLine": 30,
				"startLine": 13,
			},
		},
	]
	count(result) == 1
}

test_aws_emr_cluster_ensure_security_groups_of_emr_clusters_are_not_open_to_the_world_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_emr_cluster",
				"cluster_ok",
			],
			"Attributes": {
				"applications": ["Spark"],
				"name": "emr-test-arn",
				"release_label": "emr-4.6.0",
			},
			"Blocks": [{
				"Type": "ec2_attributes",
				"Labels": [],
				"Attributes": {
					"emr_managed_master_security_group": "aws_security_group.block_access_ok.id",
					"emr_managed_slave_security_group": "aws_security_group.block_access_ok.id",
					"instance_profile": "connected_to_aws_iam_instance_profile",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 11,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_security_group",
				"block_access_ok",
			],
			"Attributes": {
				"description": "Block all traffic",
				"name": "block_access",
			},
			"Blocks": [
				{
					"Type": "ingress",
					"Labels": [],
					"Attributes": {
						"cidr_blocks": ["0.0.0.0/0"],
						"from_port": "0",
						"protocol": "-1",
						"to_port": "0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 22,
						"startLine": 17,
					},
				},
				{
					"Type": "egress",
					"Labels": [],
					"Attributes": {
						"cidr_blocks": ["10.0.0.0/16"],
						"from_port": "0",
						"protocol": "-1",
						"to_port": "0",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 29,
						"startLine": 24,
					},
				},
			],
			"line_range": {
				"endLine": 30,
				"startLine": 13,
			},
		},
	]
	count(result) == 1
}

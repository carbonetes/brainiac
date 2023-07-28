package lib.terraform.CB_TFAWS_270

test_aws_msk_cluster_msk_nodes_are_private_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_msk_cluster",
			"example",
		],
		"Attributes": {
			"cluster_name": "example-cluster",
			"kafka_version": "2.8.0",
			"number_of_broker_nodes": "3",
		},
		"Blocks": [{
			"Type": "broker_node_group_info",
			"Labels": [],
			"Attributes": {
				"client_subnets": [
					"subnet-12345678",
					"subnet-87654321",
				],
				"instance_type": "kafka.m5.large",
				"security_groups": ["sg-12345678"],
			},
			"Blocks": [
				{
					"Type": "storage_info",
					"Labels": [],
					"Attributes": {},
					"Blocks": [{
						"Type": "ebs_storage_info",
						"Labels": [],
						"Attributes": {"volume_size": "1000"},
						"Blocks": [],
						"line_range": {
							"endLine": 14,
							"startLine": 12,
						},
					}],
					"line_range": {
						"endLine": 15,
						"startLine": 11,
					},
				},
				{
					"Type": "connectivity_info",
					"Labels": [],
					"Attributes": {},
					"Blocks": [
						{
							"Type": "client_broker",
							"Labels": [],
							"Attributes": {"security_groups": ["sg-87654321"]},
							"Blocks": [],
							"line_range": {
								"endLine": 20,
								"startLine": 18,
							},
						},
						{
							"Type": "public_access",
							"Labels": [],
							"Attributes": {"type": "ENI_ACL"},
							"Blocks": [],
							"line_range": {
								"endLine": 25,
								"startLine": 23,
							},
						},
					],
					"line_range": {
						"endLine": 26,
						"startLine": 17,
					},
				},
			],
			"line_range": {
				"endLine": 27,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 28,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_msk_cluster_msk_nodes_are_private_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"other_resource_type",
			"test",
		],
		"Attributes": {
			"deployment_type": "MULTI_AZ_1",
			"kms_key_id": "",
			"preferred_subnet_id": "aws_subnet.test1.id",
			"storage_capacity": "1024",
			"subnet_ids": "aws_subnet.test1.id",
			"throughput_capacity": "512",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 0
}

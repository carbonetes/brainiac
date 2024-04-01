package lib.terraform.CB_TFAWS_270

import rego.v1 

test_aws_msk_cluster_msk_nodes_are_private_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_msk_cluster",
				"example",
			],
			"Attributes": {
				"cluster_name": "my-msk-cluster",
				"kafka_version": "2.8.0",
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
					"security_groups": "aws_security_group.example.id",
				},
				"Blocks": [{
					"Type": "connectivity_info",
					"Labels": [],
					"Attributes": {
						"client_broker": true,
						"host": "b-1.example.amazonaws.com",
						"port": "9094",
					},
					"Blocks": [
						{
							"Type": "encryption_in_transit",
							"Labels": [],
							"Attributes": {
								"client_broker": "TLS_PLAINTEXT",
								"in_cluster": "TLS_PLAINTEXT",
							},
							"Blocks": [],
							"line_range": {
								"endLine": 17,
								"startLine": 14,
							},
						},
						{
							"Type": "public_access",
							"Labels": [],
							"Attributes": {"type": "ENABLED"},
							"Blocks": [],
							"line_range": {
								"endLine": 21,
								"startLine": 19,
							},
						},
					],
					"line_range": {
						"endLine": 22,
						"startLine": 10,
					},
				}],
				"line_range": {
					"endLine": 23,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 24,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_security_group",
				"example",
			],
			"Attributes": {"name_prefix": "allow-"},
			"Blocks": [],
			"line_range": {
				"endLine": 28,
				"startLine": 26,
			},
		},
	]
	count(result) == 1
}

test_aws_msk_cluster_msk_nodes_are_private_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_msk_cluster",
				"example",
			],
			"Attributes": {
				"cluster_name": "my-msk-cluster",
				"kafka_version": "2.8.0",
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
					"security_groups": "aws_security_group.example.id",
				},
				"Blocks": [{
					"Type": "connectivity_info",
					"Labels": [],
					"Attributes": {
						"client_broker": true,
						"host": "b-1.example.amazonaws.com",
						"port": "9094",
					},
					"Blocks": [
						{
							"Type": "encryption_in_transit",
							"Labels": [],
							"Attributes": {
								"client_broker": "TLS_PLAINTEXT",
								"in_cluster": "TLS_PLAINTEXT",
							},
							"Blocks": [],
							"line_range": {
								"endLine": 17,
								"startLine": 14,
							},
						},
						{
							"Type": "public_access",
							"Labels": [],
							"Attributes": {"type": "SERVICE_PROVIDED_EIPS"},
							"Blocks": [],
							"line_range": {
								"endLine": 21,
								"startLine": 19,
							},
						},
					],
					"line_range": {
						"endLine": 22,
						"startLine": 10,
					},
				}],
				"line_range": {
					"endLine": 23,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 24,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_security_group",
				"example",
			],
			"Attributes": {"name_prefix": "allow-"},
			"Blocks": [],
			"line_range": {
				"endLine": 28,
				"startLine": 26,
			},
		},
	]
	count(result) == 1
}

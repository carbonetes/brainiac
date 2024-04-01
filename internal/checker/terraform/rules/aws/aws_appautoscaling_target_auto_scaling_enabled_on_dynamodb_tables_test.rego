package lib.terraform.CB_TFAWS_350

import rego.v1 

test_aws_appautoscaling_target_auto_scaling_enabled_on_dynamodb_tables_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_dynamodb_table",
				"pass",
			],
			"Attributes": {
				"billing_mode": "PROVISIONED",
				"hash_key": "user-id",
				"name": "user",
				"read_capacity": "10",
				"write_capacity": "10",
			},
			"Blocks": [{
				"Type": "attribute",
				"Labels": [],
				"Attributes": {
					"name": "user-id",
					"type": "S",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 7,
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
				"aws_appautoscaling_target",
				"pass",
			],
			"Attributes": {
				"max_capacity": "15",
				"min_capacity": "1",
				"resource_id": "aws_dynamodb_table.pass.name",
				"scalable_dimension": "dynamodb:table:ReadCapacityUnits",
				"service_namespace": "dynamodb",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 19,
				"startLine": 13,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_appautoscaling_policy",
				"pass",
			],
			"Attributes": {
				"name": "rcu-auto-scaling",
				"policy_type": "TargetTrackingScaling",
				"resource_id": "aws_appautoscaling_target.pass.resource_id",
				"scalable_dimension": "aws_appautoscaling_target.pass.scalable_dimension",
				"service_namespace": "aws_appautoscaling_target.pass.service_namespace",
			},
			"Blocks": [{
				"Type": "target_tracking_scaling_policy_configuration",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "predefined_metric_specification",
					"Labels": [],
					"Attributes": {"predefined_metric_type": "RDSReaderAverageCPUUtilization"},
					"Blocks": [],
					"line_range": {
						"endLine": 31,
						"startLine": 29,
					},
				}],
				"line_range": {
					"endLine": 32,
					"startLine": 28,
				},
			}],
			"line_range": {
				"endLine": 33,
				"startLine": 21,
			},
		},
	]
	count(result) == 1
}

test_aws_appautoscaling_target_auto_scaling_enabled_on_dynamodb_tables_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_dynamodb_table",
				"pass",
			],
			"Attributes": {
				"billing_mode": "",
				"hash_key": "user-id",
				"name": "user",
				"read_capacity": "10",
				"write_capacity": "10",
			},
			"Blocks": [{
				"Type": "attribute",
				"Labels": [],
				"Attributes": {
					"name": "user-id",
					"type": "S",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 7,
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
				"aws_appautoscaling_target",
				"pass",
			],
			"Attributes": {
				"max_capacity": "15",
				"min_capacity": "1",
				"resource_id": "",
				"scalable_dimension": "dynamodb:table:ReadCapacityUnits",
				"service_namespace": "",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 19,
				"startLine": 13,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_appautoscaling_policy",
				"pass",
			],
			"Attributes": {
				"name": "rcu-auto-scaling",
				"policy_type": "TargetTrackingScaling",
				"resource_id": "",
				"scalable_dimension": "aws_appautoscaling_target.pass.scalable_dimension",
				"service_namespace": "aws_appautoscaling_target.pass.service_namespace",
			},
			"Blocks": [{
				"Type": "target_tracking_scaling_policy_configuration",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "predefined_metric_specification",
					"Labels": [],
					"Attributes": {"predefined_metric_type": "RDSReaderAverageCPUUtilization"},
					"Blocks": [],
					"line_range": {
						"endLine": 31,
						"startLine": 29,
					},
				}],
				"line_range": {
					"endLine": 32,
					"startLine": 28,
				},
			}],
			"line_range": {
				"endLine": 33,
				"startLine": 21,
			},
		},
	]
	count(result) == 1
}

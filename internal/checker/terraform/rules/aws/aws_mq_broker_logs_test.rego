package lib.terraform.CB_TFAWS_036
import rego.v1

test_aws_mq_broker_logs_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_mq_broker",
			"example",
		],
		"Attributes": {
			"auto_minor_version_upgrade": true,
			"engine_type": "ActiveMQ",
			"engine_version": "5.15.12",
			"host_instance_type": "mq.t2.micro",
			"name": "example-broker",
			"publicly_accessible": false,
		},
		"Blocks": [
			{
				"Type": "configuration",
				"Labels": [],
				"Attributes": {
					"id": "default-configuration",
					"revision": "1",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 9,
				},
			},
			{
				"Type": "logs",
				"Labels": [],
				"Attributes": {"general": true},
				"Blocks": [],
				"line_range": {
					"endLine": 16,
					"startLine": 14,
				},
			},
		],
		"line_range": {
			"endLine": 21,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_mq_broker_logs_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_mq_broker",
			"example",
		],
		"Attributes": {
			"auto_minor_version_upgrade": true,
			"engine_type": "ActiveMQ",
			"engine_version": "5.15.12",
			"host_instance_type": "mq.t2.micro",
			"name": "example-broker",
			"publicly_accessible": false,
		},
		"Blocks": [
			{
				"Type": "configuration",
				"Labels": [],
				"Attributes": {
					"id": "default-configuration",
					"revision": "1",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 12,
					"startLine": 9,
				},
			},
			{
				"Type": "logs",
				"Labels": [],
				"Attributes": {"general": false},
				"Blocks": [],
				"line_range": {
					"endLine": 16,
					"startLine": 14,
				},
			},
		],
		"line_range": {
			"endLine": 21,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

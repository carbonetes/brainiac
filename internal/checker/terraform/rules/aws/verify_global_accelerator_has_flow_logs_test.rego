package lib.terraform.CB_TFAWS_084
import rego.v1

test_global_accelerator_flow_logs_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_globalaccelerator_accelerator",
			"example",
		],
		"Attributes": {
			"enabled": true,
			"ip_address_type": "IPV4",
			"name": "Example",
		},
		"Blocks": [{
			"Type": "attributes",
			"Labels": [],
			"Attributes": {
				"flow_logs_enabled": true,
				"flow_logs_s3_bucket": "example-bucket",
				"flow_logs_s3_prefix": "flow-logs/",
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
	}]

	count(result) == 1
}

test_global_accelerator_flow_logs_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_globalaccelerator_accelerator",
			"example",
		],
		"Attributes": {
			"enabled": true,
			"ip_address_type": "IPV4",
			"name": "Example",
		},
		"Blocks": [{
			"Type": "attributes",
			"Labels": [],
			"Attributes": {
				"flow_logs_enabled": false,
				"flow_logs_s3_bucket": "example-bucket",
				"flow_logs_s3_prefix": "flow-logs/",
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
	}]
	count(result) == 1
}

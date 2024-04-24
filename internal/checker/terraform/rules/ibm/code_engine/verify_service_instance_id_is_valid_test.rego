package lib.terraform.CB_TFIBM_073

import rego.v1

test_service_instance_resource_key_id_valid_pass if {
	result := passed with input as [{
		"Attributes": {
			"data": {
				"key1": "value1",
				"key2": "value2",
			},
			"format": "generic",
			"name": "my-secret",
			"project_id": "15314cc3-85b4-4338-903f-c28cdee6d005",
		},
		"Blocks": [{
			"Attributes": {},
			"Blocks": [
				{
					"Attributes": {"id": "123456-8910-11-1213asdds-ass121-2s1a"},
					"Blocks": [],
					"Labels": [],
					"Type": "resource_key",
					"line_range": {
						"endLine": 14,
						"startLine": 12,
					},
				},
				{
					"Attributes": {"crn": "your-role-crn"},
					"Blocks": [],
					"Labels": [],
					"Type": "role",
					"line_range": {
						"endLine": 17,
						"startLine": 15,
					},
				},
				{
					"Attributes": {"id": "your-service-instance-id-09876543210"},
					"Blocks": [],
					"Labels": [],
					"Type": "service_instance",
					"line_range": {
						"endLine": 20,
						"startLine": 18,
					},
				},
			],
			"Labels": [],
			"Type": "service_access",
			"line_range": {
				"endLine": 21,
				"startLine": 11,
			},
		}],
		"Labels": [
			"ibm_code_engine_secret",
			"code_engine_secret_instance",
		],
		"Type": "resource",
		"line_range": {
			"endLine": 22,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_service_instance_resource_key_id_valid_fail if {
	result := failed with input as [{
		"Attributes": {
			"data": {
				"key1": "value1",
				"key2": "value2",
			},
			"format": "generic",
			"name": "my-secret",
			"project_id": "15314cc3-85b4-4338-903f-c28cdee6d005",
		},
		"Blocks": [{
			"Attributes": {},
			"Blocks": [
				{
					"Attributes": {"id": "your-resource-key-id"},
					"Blocks": [],
					"Labels": [],
					"Type": "resource_key",
					"line_range": {
						"endLine": 14,
						"startLine": 12,
					},
				},
				{
					"Attributes": {"crn": "your-role-crn"},
					"Blocks": [],
					"Labels": [],
					"Type": "role",
					"line_range": {
						"endLine": 17,
						"startLine": 15,
					},
				},
				{
					"Attributes": {"id": "-your-service-instance-id"},
					"Blocks": [],
					"Labels": [],
					"Type": "service_instance",
					"line_range": {
						"endLine": 20,
						"startLine": 18,
					},
				},
			],
			"Labels": [],
			"Type": "service_access",
			"line_range": {
				"endLine": 21,
				"startLine": 11,
			},
		}],
		"Labels": [
			"ibm_code_engine_secret",
			"code_engine_secret_instance",
		],
		"Type": "resource",
		"line_range": {
			"endLine": 22,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

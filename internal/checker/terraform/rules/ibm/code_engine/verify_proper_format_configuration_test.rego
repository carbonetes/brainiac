package lib.terraform.CB_TFIBM_071
import rego.v1

test_proper_format_configuration_pass if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_code_engine_secret",
			"code_engine_secret_instance",
		],
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
			"Type": "service_access",
			"Labels": [],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "resource_key",
					"Labels": [],
					"Attributes": {"id": "your-resource-key-id"},
					"Blocks": [],
					"line_range": {
						"endLine": 14,
						"startLine": 12,
					},
				},
				{
					"Type": "role",
					"Labels": [],
					"Attributes": {"crn": "your-role-crn"},
					"Blocks": [],
					"line_range": {
						"endLine": 17,
						"startLine": 15,
					},
				},
				{
					"Type": "service_instance",
					"Labels": [],
					"Attributes": {"id": "your-service-instance-id"},
					"Blocks": [],
					"line_range": {
						"endLine": 20,
						"startLine": 18,
					},
				},
			],
			"line_range": {
				"endLine": 21,
				"startLine": 11,
			},
		}],
		"line_range": {
			"endLine": 22,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_proper_format_configuration_fail if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_code_engine_secret",
			"code_engine_secret_instance",
		],
		"Attributes": {
			"data": {
				"key1": "value1",
				"key2": "value2",
			},
			"format": "formatted",
			"name": "my-secret",
			"project_id": "15314cc3-85b4-4338-903f-c28cdee6d005",
		},
		"Blocks": [{
			"Type": "service_access",
			"Labels": [],
			"Attributes": {},
			"Blocks": [
				{
					"Type": "resource_key",
					"Labels": [],
					"Attributes": {"id": "your-resource-key-id"},
					"Blocks": [],
					"line_range": {
						"endLine": 14,
						"startLine": 12,
					},
				},
				{
					"Type": "role",
					"Labels": [],
					"Attributes": {"crn": "your-role-crn"},
					"Blocks": [],
					"line_range": {
						"endLine": 17,
						"startLine": 15,
					},
				},
				{
					"Type": "service_instance",
					"Labels": [],
					"Attributes": {"id": "your-service-instance-id"},
					"Blocks": [],
					"line_range": {
						"endLine": 20,
						"startLine": 18,
					},
				},
			],
			"line_range": {
				"endLine": 21,
				"startLine": 11,
			},
		}],
		"line_range": {
			"endLine": 22,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

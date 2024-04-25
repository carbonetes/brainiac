package lib.terraform.CB_TFIBM_042

import rego.v1

test_guid_properly_configured_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_service_instance",
			"service_instance",
		],
		"Attributes": {
			"name": "myspeech",
			"parameters": {
				"key1": "value1",
				"key2": "value2",
			},
			"plan": "lite",
			"service": "speech_to_text",
			"space_guid": "data.ibm_space.spacedata.id",
			"tags": [
				"cluster-service",
				"cluster-bind",
			],
			"wait_time_minutes": "10",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_guid_properly_configured_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_service_instance",
			"service_instance",
		],
		"Attributes": {
			"name": "myspeech",
			"parameters": {
				"key1": "value1",
				"key2": "value2",
			},
			"plan": "lite",
			"service": "speech_to_text",
			"space_guid": "",
			"tags": [
				"cluster-service",
				"cluster-bind",
			],
			"wait_time_minutes": "10",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_guid_properly_configured_pass if {
	result := passed with input as [
		{
			"Type": "data",
			"Labels": [
				"ibm_service_instance",
				"service_instance",
			],
			"Attributes": {"name": "mycloudant"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ibm_service_key",
				"serviceKey",
			],
			"Attributes": {
				"name": "mycloudantkey",
				"parameters": {"example_parameter": "value"},
				"service_instance_guid": "data.ibm_service_instance.service_instance.id",
				"tags": [
					"tag1",
					"tag2",
				],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_guid_properly_configured_fail if {
	result := failed with input as [
		{
			"Type": "data",
			"Labels": [
				"ibm_service_instance",
				"service_instance",
			],
			"Attributes": {"name": "mycloudant"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"ibm_service_key",
				"serviceKey",
			],
			"Attributes": {
				"name": "mycloudantkey",
				"parameters": {"example_parameter": "value"},
				"service_instance_guid": "",
				"tags": [
					"tag1",
					"tag2",
				],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 12,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

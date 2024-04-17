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

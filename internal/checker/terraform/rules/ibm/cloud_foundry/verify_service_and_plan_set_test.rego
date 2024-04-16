package lib.terraform.CB_TFIBM_035

import rego.v1

test_service_plan_set_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_service_instance",
			"service_instance",
		],
		"Attributes": {
			"plan": "lite",
			"service": "speech_to_text",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ervice_plan_set_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_service_instance",
			"service_instance",
		],
		"Attributes": {
			"plan": "",
			"service": "speech_to_text"
		},
		"Blocks": [],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

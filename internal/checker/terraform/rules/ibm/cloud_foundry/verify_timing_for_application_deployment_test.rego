package lib.terraform.CB_TFIBM_018
import rego.v1

test_timing_for_application_deployment_pass if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_app",
			"app",
		],
		"Attributes": {
			"wait_time_minutes": "20",
			"wait_timeout_minutes": "90"
		},
		"Blocks": [],
		"line_range": {
			"endLine": 25,
			"startLine": 2,
		}
	}]
	count(result) == 1
}

test_timing_for_application_deployment_fail if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ibm_app",
			"app",
		],
		"Attributes": {
			"wait_time_minutes": "15",
			"wait_timeout_minutes": "90"
		},
		"Blocks": [],
		"line_range": {
			"endLine": 25,
			"startLine": 2,
		}
	}]
	count(result) == 1
}

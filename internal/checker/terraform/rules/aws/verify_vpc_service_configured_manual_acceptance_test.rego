package lib.terraform.CB_TFAWS_119
import rego.v1

test_vpc_service_configure_manual_acceptance if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_vpc_endpoint_service",
			"example",
		],
		"Attributes": {
			"acceptance_required": true,
			"service_name": "com.example.vpc-endpoint-service",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_vpc_service_not_configure_manual_acceptance if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_vpc_endpoint_service",
			"example",
		],
		"Attributes": {
			"acceptance_required": false,
			"service_name": "com.example.vpc-endpoint-service",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

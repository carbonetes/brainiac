package lib.terraform.CB_TFAWS_030
import rego.v1

test_verify_kms_key_wildcard_principal_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_kms_key",
			"example_policy",
		],
		"Attributes": {"policy": "          {\n            \"Statement\": [\n              {\n                \"Effect\": \"Deny\",\n                \"Principal\": {\n                  \"AWS\": \"*\"\n                }\n              }\n            ]\n          }\n"},
		"Blocks": [],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_verify_kms_key_wildcard_principal_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_kms_key",
			"example_policy",
		],
		"Attributes": {"policy": "          {\n            \"Statement\": [\n              {\n                \"Effect\": \"Allow\",\n                \"Principal\": {\n                  \"AWS\": \"*\"\n                }\n              }\n            ]\n          }\n"},
		"Blocks": [],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

package lib.terraform.CB_TFAWS_242
import rego.v1

test_aws_comprehend_entity_recognizer_comprehend_entity_recognizer_model_encrypted_by_kms_utilizing_cmk_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_comprehend_entity_recognizer",
			"example",
		],
		"Attributes": {"model_kms_key_id": "kms_key_id"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_comprehend_entity_recognizer_comprehend_entity_recognizer_model_encrypted_by_kms_utilizing_cmk_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_comprehend_entity_recognizer",
			"example",
		],
		"Attributes": {"model_kms_key_id": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

package lib.terraform.CB_TFAWS_221
import rego.v1

test_verify_acm_cert_create_before_destroy_enabled_passed if {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_acm_certificate",
									"example"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "lifecycle",
										"Labels": [],
										"Attributes": {
										"create_before_destroy": true
										},
										"Blocks": [],
										"line_range": {
										"endLine": 4,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 5,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_acm_cert_create_before_destroy_enabled_failed if {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_acm_certificate",
									"example"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "lifecycle",
										"Labels": [],
										"Attributes": {
										"create_before_destroy": false
										},
										"Blocks": [],
										"line_range": {
										"endLine": 4,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 5,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

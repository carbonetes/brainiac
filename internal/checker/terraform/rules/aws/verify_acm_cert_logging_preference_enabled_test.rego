package lib.terraform.CB_TFAWS_222
import rego.v1

test_verify_acm_cert_logging_preference_enabled_passed if {
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
										"Type": "options",
										"Labels": [],
										"Attributes": {
										"certificate_transparency_logging_preference": "ENABLED"
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

test_verify_acm_cert_logging_preference_enabled_failed if {
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
										"Type": "options",
										"Labels": [],
										"Attributes": {
										"certificate_transparency_logging_preference": "DISABLED"
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

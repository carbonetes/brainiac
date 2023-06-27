package lib.terraform.CB_TFOCI_018

test_verify_iam_password_length_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_authentication_policy",
									"pass"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "password_policy",
										"Labels": [],
										"Attributes": {
										"minimum_password_length": "14"
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

test_verify_iam_password_length_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_authentication_policy",
									"pass"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "password_policy",
										"Labels": [],
										"Attributes": {
										"minimum_password_length": "5"
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

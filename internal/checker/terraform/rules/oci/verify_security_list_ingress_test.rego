package lib.terraform.CB_TFOCI_016

test_verify_security_list_ingress_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_core_security_list",
									"pass"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "ingress_security_rules",
										"Labels": [],
										"Attributes": {
										"protocol": "all"
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

test_verify_security_list_ingress_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_core_security_list",
									"pass"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "ingress_security_rules",
										"Labels": [],
										"Attributes": {
										"protocol": ""
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

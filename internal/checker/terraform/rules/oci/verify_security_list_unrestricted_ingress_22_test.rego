package lib.terraform.CB_TFOCI_019

test_verify_security_list_unrestricted_ingress_22_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_core_security_list",
									"pass0"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "ingress_security_rules",
										"Labels": [],
										"Attributes": {
										"source": "0.0.0.0/0"
										},
										"Blocks": [
										{
										"Type": "tcp_options",
										"Labels": [],
										"Attributes": {
										"max": "43",
										"min": "41"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 8,
										"startLine": 5
										}
										},
										{
										"Type": "udp_options",
										"Labels": [],
										"Attributes": {
										"max": "13",
										"min": "10"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 12,
										"startLine": 9
										}
										}
										],
										"line_range": {
										"endLine": 13,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 14,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_security_list_unrestricted_ingress_22_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_core_security_list",
									"pass0"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "ingress_security_rules",
										"Labels": [],
										"Attributes": {
										"source": "0.0.0.0/0"
										},
										"Blocks": [
										{
										"Type": "tcp_options",
										"Labels": [],
										"Attributes": {
										"max": "23",
										"min": "21"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 8,
										"startLine": 5
										}
										},
										{
										"Type": "udp_options",
										"Labels": [],
										"Attributes": {
										"max": "13",
										"min": "10"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 12,
										"startLine": 9
										}
										}
										],
										"line_range": {
										"endLine": 13,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 14,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

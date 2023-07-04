package lib.terraform.CB_TFOCI_020

test_verify_security_list_unrestricted_ingress_3389_passed {
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
										"protocol": "var.security_list_ingress_security_rules_protocol",
										"source": "0.0.0.0/0"
										},
										"Blocks": [
										{
										"Type": "tcp_options",
										"Labels": [],
										"Attributes": {
										"max": "24",
										"min": "23"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 10,
										"startLine": 7
										}
										},
										{
										"Type": "udp_options",
										"Labels": [],
										"Attributes": {
										"max": "3391",
										"min": "3391"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 14,
										"startLine": 11
										}
										}
										],
										"line_range": {
										"endLine": 15,
										"startLine": 3
										}
									}
									],
									"line_range": {
									"endLine": 16,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_security_list_unrestricted_ingress_3389_failed {
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
										"protocol": "var.security_list_ingress_security_rules_protocol",
										"source": "0.0.0.0/0"
										},
										"Blocks": [
										{
										"Type": "tcp_options",
										"Labels": [],
										"Attributes": {
										"max": "4000",
										"min": "3390"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 10,
										"startLine": 7
										}
										},
										{
										"Type": "udp_options",
										"Labels": [],
										"Attributes": {
										"max": "3390",
										"min": "3389"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 14,
										"startLine": 11
										}
										}
										],
										"line_range": {
										"endLine": 15,
										"startLine": 3
										}
									}
									],
									"line_range": {
									"endLine": 16,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

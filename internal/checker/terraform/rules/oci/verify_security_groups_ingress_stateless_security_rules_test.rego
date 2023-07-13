package lib.terraform.CB_TFOCI_021

test_verify_security_groups_ingress_stateless_security_rules_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_core_network_security_group_security_rule",
									"pass"
									],
									"Attributes": {
									"direction": "INGRESS",
									"stateless": true
									},
									"Blocks": [],
									"line_range": {
									"endLine": 4,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_security_groups_ingress_stateless_security_rules_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_core_network_security_group_security_rule",
									"pass"
									],
									"Attributes": {
									"direction": "INGRESS",
									"stateless": false
									},
									"Blocks": [],
									"line_range": {
									"endLine": 4,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

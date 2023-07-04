package lib.terraform.CB_TFOCI_022

test_verify_security_group_unrestricted_ingress_22_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_core_network_security_group_security_rule",
									"example"
									],
									"Attributes": {
									"direction": "INGRESS",
									"source": "0.0.0.0/0"
									},
									"Blocks": [
									{
										"Type": "tcp_options",
										"Labels": [],
										"Attributes": {},
										"Blocks": [
										{
										"Type": "destination_port_range",
										"Labels": [],
										"Attributes": {
										"max": "23",
										"min": "23"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 8,
										"startLine": 5
										}
										}
										],
										"line_range": {
										"endLine": 9,
										"startLine": 4
										}
									},
									{
										"Type": "udp_options",
										"Labels": [],
										"Attributes": {},
										"Blocks": [
										{
										"Type": "destination_port_range",
										"Labels": [],
										"Attributes": {
										"max": "23",
										"min": "23"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 15,
										"startLine": 12
										}
										}
										],
										"line_range": {
										"endLine": 16,
										"startLine": 11
										}
									}
									],
									"line_range": {
									"endLine": 17,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_security_group_unrestricted_ingress_22_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_core_network_security_group_security_rule",
									"example"
									],
									"Attributes": {
									"direction": "INGRESS",
									"source": "0.0.0.0/0"
									},
									"Blocks": [
									{
										"Type": "tcp_options",
										"Labels": [],
										"Attributes": {},
										"Blocks": [
										{
										"Type": "destination_port_range",
										"Labels": [],
										"Attributes": {
										"max": "23",
										"min": "23"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 8,
										"startLine": 5
										}
										}
										],
										"line_range": {
										"endLine": 9,
										"startLine": 4
										}
									},
									{
										"Type": "udp_options",
										"Labels": [],
										"Attributes": {},
										"Blocks": [
										{
										"Type": "destination_port_range",
										"Labels": [],
										"Attributes": {
										"max": "23",
										"min": "22"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 15,
										"startLine": 12
										}
										}
										],
										"line_range": {
										"endLine": 16,
										"startLine": 11
										}
									}
									],
									"line_range": {
									"endLine": 17,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

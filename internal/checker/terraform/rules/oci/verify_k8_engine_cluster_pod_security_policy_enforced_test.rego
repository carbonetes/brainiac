package lib.terraform.CB_TFOCI_028

test_verify_k8_engine_cluster_pod_security_policy_enforced_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_containerengine_cluster",
									"fail_1"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "options",
										"Labels": [],
										"Attributes": {},
										"Blocks": [
										{
										"Type": "admission_controller_options",
										"Labels": [],
										"Attributes": {
										"is_pod_security_policy_enabled": true
										},
										"Blocks": [],
										"line_range": {
										"endLine": 5,
										"startLine": 3
										}
										}
										],
										"line_range": {
										"endLine": 6,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 7,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_k8_engine_cluster_pod_security_policy_enforced_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_containerengine_cluster",
									"fail_1"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "options",
										"Labels": [],
										"Attributes": {},
										"Blocks": [
										{
										"Type": "admission_controller_options",
										"Labels": [],
										"Attributes": {
										"is_pod_security_policy_enabled": false
										},
										"Blocks": [],
										"line_range": {
										"endLine": 5,
										"startLine": 3
										}
										}
										],
										"line_range": {
										"endLine": 6,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 7,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

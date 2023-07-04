package lib.terraform.CB_TFOCI_025

test_verify_kubernetes_engine_cluster_endpoint_config_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_containerengine_cluster",
									"pass_1"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "endpoint_config",
										"Labels": [],
										"Attributes": {
										"nsg_ids": [
										"ocid1.networksecuritygroup.oc1..pud_cki_1",
										"ocid2.networksecuritygroup.oc1..pud_cki_2"
										]
										},
										"Blocks": [],
										"line_range": {
										"endLine": 8,
										"startLine": 3
										}
									}
									],
									"line_range": {
									"endLine": 9,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_kubernetes_engine_cluster_endpoint_config_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_containerengine_cluster",
									"pass_1"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "endpoint_config",
										"Labels": [],
										"Attributes": {
										"nsg_ids": []
										},
										"Blocks": [],
										"line_range": {
										"endLine": 8,
										"startLine": 3
										}
									}
									],
									"line_range": {
									"endLine": 9,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

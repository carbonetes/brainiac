package lib.terraform.CB_TFOCI_027

test_verify_k8_engine_cluster_boot_volume_config_in_transit_encryption_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_containerengine_node_pool",
									"fail_1"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "node_config_details",
										"Labels": [],
										"Attributes": {
										"is_pv_encryption_in_transit_enabled": true
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

test_verify_k8_engine_cluster_boot_volume_config_in_transit_encryption_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_containerengine_node_pool",
									"fail_1"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "node_config_details",
										"Labels": [],
										"Attributes": {
										"is_pv_encryption_in_transit_enabled": false
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

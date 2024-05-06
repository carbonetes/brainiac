package lib.terraform.CB_TFAWS_228
import rego.v1

test_verify_dax_endpoint_tls_passed if {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_dax_cluster",
									"pass"
									],
									"Attributes": {
									"cluster_endpoint_encryption_type": "TLS"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 3,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_dax_endpoint_tls_failed if {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_dax_cluster",
									"pass"
									],
									"Attributes": {
									"cluster_endpoint_encryption_type": ""
									},
									"Blocks": [],
									"line_range": {
									"endLine": 3,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

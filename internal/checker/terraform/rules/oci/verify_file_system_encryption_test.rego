package lib.terraform.CB_TFOCI_003

test_verify_file_system_encryption_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_file_storage_file_system",
									"example"
									],
									"Attributes": {
									"kms_key_id": "\u003cCUSTOMER_MANAGED_KEY_OCID\u003e"
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

test_verify_file_system_encryption_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_file_storage_file_system",
									"example"
									],
									"Attributes": {
									"kms_key_id": ""
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

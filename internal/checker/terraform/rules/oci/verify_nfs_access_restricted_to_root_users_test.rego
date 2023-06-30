package lib.terraform.CB_TFOCI_026

test_verify_nfs_access_restricted_to_root_users_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_file_storage_export",
									"fail_2"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "export_options",
										"Labels": [],
										"Attributes": {
										"anonymous_gid": "65534",
										"anonymous_uid": "65534",
										"identity_squash": "root"
										},
										"Blocks": [],
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

test_verify_nfs_access_restricted_to_root_users_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_file_storage_export",
									"fail_2"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "export_options",
										"Labels": [],
										"Attributes": {
										"anonymous_gid": "65533",
										"anonymous_uid": "65534",
										"identity_squash": "root"
										},
										"Blocks": [],
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

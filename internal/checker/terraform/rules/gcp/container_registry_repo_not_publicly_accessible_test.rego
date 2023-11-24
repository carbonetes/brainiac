package lib.terraform.CB_TFGCP_112

test_container_registry_not_publicly_accessible {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_container_registry",
				"example",
			],
			"Attributes": {"location": "global"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_storage_bucket_iam_member",
				"member",
			],
			"Attributes": {
				"bucket": "google_kms_key_ring.example.id",
				"role": "roles/cloudkms.cryptoKeyEncrypter",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_container_registry_publicly_accessible {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_container_registry",
				"example",
			],
			"Attributes": {"location": "global"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_storage_bucket_iam_member",
				"member",
			],
			"Attributes": {
				"bucket": "google_kms_key_ring.example.id",
				"member": "allUsers",
				"role": "roles/cloudkms.cryptoKeyEncrypter",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

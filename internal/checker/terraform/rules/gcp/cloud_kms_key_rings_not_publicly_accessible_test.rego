package lib.terraform.CB_TFGCP_107

test_cloud_kms_key_rings_not_pubclicly_accesible {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_kms_key_ring",
				"example-keyring",
			],
			"Attributes": {
				"location": "global",
				"name": "keyring-example",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_kms_key_ring_iam_member",
				"member",
			],
			"Attributes": {
				"key_ring_id": "google_kms_key_ring.example-keyring.id",
				"role": "roles/cloudkms.cryptoKeyEncrypter",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}

test_cloud_kms_key_rings_pubclicly_accesible {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_kms_key_ring",
				"example-keyring",
			],
			"Attributes": {
				"location": "global",
				"name": "keyring-example",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_kms_key_ring_iam_member",
				"member",
			],
			"Attributes": {
				"key_ring_id": "google_kms_key_ring.example-keyring.id",
				"member": "allUsers",
				"role": "roles/cloudkms.cryptoKeyEncrypter",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}

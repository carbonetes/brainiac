package lib.terraform.CB_TFGCP_100

test_google_storage_bucket_uniform_bucket_level_access_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_vertex_ai_metadata_store",
            "store"
        ],
        "Attributes": {
            "description": "Store to test the terraform module",
            "name": "test-store",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "encryption_spec",
                "Labels": [],
                "Attributes": {
                    "kms_key_name": "kms_key_name_sample"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_storage_bucket_uniform_bucket_level_access_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_vertex_ai_metadata_store",
            "store"
        ],
        "Attributes": {
            "description": "Store to test the terraform module",
            "name": "test-store",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "encryption_spec",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
	count(result) == 1
}

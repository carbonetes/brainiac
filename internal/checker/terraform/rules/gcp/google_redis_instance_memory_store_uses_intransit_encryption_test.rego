package lib.terraform.CB_TFGCP_101

test_google_redis_instance_memory_store_uses_intransit_encryption_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_redis_instance",
            "cache"
        ],
        "Attributes": {
            "memory_size_gb": "1",
            "name": "memory-cache",
            "transit_encryption_mode": "SERVER_AUTHENTICATION"
        },
        "Blocks": [
            {
                "Type": "lifecycle",
                "Labels": [],
                "Attributes": {
                    "prevent_destroy": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_redis_instance_memory_store_uses_intransit_encryption_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_redis_instance",
            "cache"
        ],
        "Attributes": {
            "memory_size_gb": "1",
            "name": "memory-cache",
            "transit_encryption_mode": "DISABLED"
        },
        "Blocks": [
            {
                "Type": "lifecycle",
                "Labels": [],
                "Attributes": {
                    "prevent_destroy": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

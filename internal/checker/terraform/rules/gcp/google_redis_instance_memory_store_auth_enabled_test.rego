package lib.terraform.CB_TFGCP_099

test_google_redis_instance_memory_store_auth_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_redis_instance",
            "cache"
        ],
        "Attributes": {
            "auth_enabled": true,
            "memory_size_gb": "1",
            "name": "memory-cache"
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

test_google_redis_instance_memory_store_auth_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_redis_instance",
            "cache"
        ],
        "Attributes": {
            "auth_enabled": false,
            "memory_size_gb": "1",
            "name": "memory-cache"
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

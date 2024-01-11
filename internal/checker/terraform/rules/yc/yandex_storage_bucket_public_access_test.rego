package lib.terraform.CB_TFYC_017

test_yandex_storage_bucket_public_access_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_storage_bucket",
            "test"
        ],
        "Attributes": {
            "acl": "private",
            "bucket": "mybucket"
        },
        "Blocks": [
            {
                "Type": "grant",
                "Labels": [],
                "Attributes": {
                    "id": "myuser",
                    "permissions": [
                        "FULL_CONTROL"
                    ],
                    "type": "CanonicalUser"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            },
            {
                "Type": "grant",
                "Labels": [],
                "Attributes": {
                    "permissions": [
                        "READ",
                        "WRITE"
                    ],
                    "type": "Group"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_yandex_storage_bucket_public_access_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_storage_bucket",
            "test"
        ],
        "Attributes": {
            "acl": "public-read",
            "bucket": "mybucket"
        },
        "Blocks": [
            {
                "Type": "grant",
                "Labels": [],
                "Attributes": {
                    "id": "myuser",
                    "permissions": [
                        "FULL_CONTROL"
                    ],
                    "type": "CanonicalUser"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            },
            {
                "Type": "grant",
                "Labels": [],
                "Attributes": {
                    "permissions": [
                        "READ",
                        "WRITE"
                    ],
                    "type": "Group",
                    "uri": "http://acs.amazonaws.com/groups/global/AllUsers"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 16,
            "startLine": 1
        }
    }]
	count(result) == 1
}
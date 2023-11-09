package lib.terraform.CB_TFGCP_031

test_google_storage_bucket_public_access_restriction_passed {
	result := passed with input as [{
        "Type": "data",
        "Labels": [
            "google_iam_policy",
            "admin"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "binding",
                "Labels": [],
                "Attributes": {
                    "members": [
                        "user:jane@example.com"
                    ],
                    "role": "roles/storage.admin"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_storage_bucket_iam_policy",
            "policy"
        ],
        "Attributes": {
            "bucket": "google_storage_bucket.default.name",
            "policy_data": "data.google_iam_policy.admin.policy_data"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 10
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_storage_bucket_iam_binding",
            "binding"
        ],
        "Attributes": {
            "bucket": "google_storage_bucket.default.name",
            "members": [
                "user:jane@example.com"
            ],
            "role": "roles/storage.admin"
        },
        "Blocks": [
            {
                "Type": "condition",
                "Labels": [],
                "Attributes": {
                    "description": "Expiring at midnight of 2019-12-31",
                    "expression": "request.time < timestamp(\"2020-01-01T00:00:00Z\")",
                    "title": "expires_after_2019_12_31"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 26,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 27,
            "startLine": 15
        }
    }]
	count(result) == 1
}

test_google_storage_bucket_public_access_restriction_failed {
	result := failed with input as [{
        "Type": "data",
        "Labels": [
            "google_iam_policy",
            "admin"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "binding",
                "Labels": [],
                "Attributes": {
                    "members": [
                        "user:jane@example.com"
                    ],
                    "role": "roles/storage.admin"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_storage_bucket_iam_policy",
            "policy"
        ],
        "Attributes": {
            "bucket": "google_storage_bucket.default.name",
            "policy_data": "data.google_iam_policy.admin.policy_data"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 10
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_storage_bucket_iam_binding",
            "binding"
        ],
        "Attributes": {
            "bucket": "google_storage_bucket.default.name",
            "members": [
                "user:jane@example.com",
                "allUsers"
            ],
            "role": "roles/storage.admin"
        },
        "Blocks": [
            {
                "Type": "condition",
                "Labels": [],
                "Attributes": {
                    "description": "Expiring at midnight of 2019-12-31",
                    "expression": "request.time < timestamp(\"2020-01-01T00:00:00Z\")",
                    "title": "expires_after_2019_12_31"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 26,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 27,
            "startLine": 15
        }
    }]
	count(result) == 1
}
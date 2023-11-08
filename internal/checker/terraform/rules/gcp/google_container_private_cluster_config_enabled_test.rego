package lib.terraform.CB_TFGCP_024

test_google_container_private_cluster_config_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_service_account",
            "default"
        ],
        "Attributes": {
            "account_id": "service-account-id",
            "display_name": "Service Account"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_container_cluster",
            "primary"
        ],
        "Attributes": {
            "initial_node_count": "3",
            "location": "us-central1-a",
            "name": "marcellus-wallace"
        },
        "Blocks": [
            {
                "Type": "node_config",
                "Labels": [],
                "Attributes": {
                    "labels": {
                        "foo": "bar"
                    },
                    "oauth_scopes": [
                        "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "service_account": "google_service_account.default.email",
                    "tags": [
                        "foo",
                        "bar"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 20,
                    "startLine": 10
                }
            },
            {
                "Type": "timeouts",
                "Labels": [],
                "Attributes": {
                    "create": "30m",
                    "update": "40m"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 24,
                    "startLine": 21
                }
            },
            {
                "Type": "private_cluster_config",
                "Labels": [],
                "Attributes": {
                    "private_endpoint": "172.143.225.225"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 27,
                    "startLine": 25
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 6
        }
    }]
	count(result) == 1
}

test_google_container_private_cluster_config_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_service_account",
            "default"
        ],
        "Attributes": {
            "account_id": "service-account-id",
            "display_name": "Service Account"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_container_cluster",
            "primary"
        ],
        "Attributes": {
            "initial_node_count": "3",
            "location": "us-central1-a",
            "name": "marcellus-wallace"
        },
        "Blocks": [
            {
                "Type": "node_config",
                "Labels": [],
                "Attributes": {
                    "labels": {
                        "foo": "bar"
                    },
                    "oauth_scopes": [
                        "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "service_account": "google_service_account.default.email",
                    "tags": [
                        "foo",
                        "bar"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 20,
                    "startLine": 10
                }
            },
            {
                "Type": "timeouts",
                "Labels": [],
                "Attributes": {
                    "create": "30m",
                    "update": "40m"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 24,
                    "startLine": 21
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 6
        }
    }]
	count(result) == 1
}
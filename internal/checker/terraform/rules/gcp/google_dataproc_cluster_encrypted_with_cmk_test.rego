package lib.terraform.CB_TFGCP_095

test_google_dataproc_cluster_encrypted_with_cmk_passed {
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
            "google_dataproc_cluster",
            "mycluster"
        ],
        "Attributes": {
            "graceful_decommission_timeout": "120s",
            "labels": {
                "foo": "bar"
            },
            "name": "mycluster",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "cluster_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "encryption_config",
                        "Labels": [],
                        "Attributes": {
                            "kms_key_name": "projects/projectId/locations/region/keyRings/keyRingName/cryptoKeys/keyName"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 17,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 18,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 6
        }
    }]
	count(result) == 1
}

test_google_dataproc_cluster_encrypted_with_cmk_failed {
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
            "google_dataproc_cluster",
            "mycluster"
        ],
        "Attributes": {
            "graceful_decommission_timeout": "120s",
            "labels": {
                "foo": "bar"
            },
            "name": "mycluster",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "cluster_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "encryption_config",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [],
                        "line_range": {
                            "endLine": 17,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 18,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 6
        }
    }]
	count(result) == 1
}

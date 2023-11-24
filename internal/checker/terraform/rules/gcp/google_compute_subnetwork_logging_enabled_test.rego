package lib.terraform.CB_TFGCP_025

test_google_compute_subnetwork_logging_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_subnetwork",
            "subnet-with-logging"
        ],
        "Attributes": {
            "ip_cidr_range": "10.2.0.0/16",
            "name": "log-test-subnetwork",
            "network": "google_compute_network.custom-test.id",
            "purpose": "REGIONAL_MANAGED_PROXY",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "log_config",
                "Labels": [],
                "Attributes": {
                    "aggregation_interval": "INTERVAL_10_MIN",
                    "flow_sampling": "0.5",
                    "metadata": "INCLUDE_ALL_METADATA"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 13,
                    "startLine": 9
                }
            }
        ],
        "line_range": {
            "endLine": 14,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_network",
            "custom-test"
        ],
        "Attributes": {
            "auto_create_subnetworks": false,
            "name": "log-test-network"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 19,
            "startLine": 16
        }
    }]
	count(result) == 1
}

test_google_compute_subnetwork_logging_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_subnetwork",
            "subnet-with-logging"
        ],
        "Attributes": {
            "ip_cidr_range": "10.2.0.0/16",
            "name": "log-test-subnetwork",
            "network": "google_compute_network.custom-test.id",
            "purpose": "INTERNAL_HTTPS_LOAD_BALANCER",
            "region": "us-central1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_network",
            "custom-test"
        ],
        "Attributes": {
            "auto_create_subnetworks": false,
            "name": "log-test-network"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 19,
            "startLine": 16
        }
    }]
	count(result) == 1
}
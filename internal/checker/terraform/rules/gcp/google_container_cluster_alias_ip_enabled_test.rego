package lib.terraform.CB_TFGCP_012

test_google_container_cluster_alias_ip_enabled_passed {
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
            "initial_node_count": "1",
            "location": "us-central1",
            "name": "my-gke-cluster",
            "remove_default_node_pool": true
        },
        "Blocks": [
            {
                "Type": "ip_allocation_policy",
                "Labels": [],
                "Attributes": {
                    "services_ipv4_cidr_block": [
                        "10.0.0.0/8",
                        "172.16.0.0/12",
                        "192.168.0.0/16"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 16
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_container_node_pool",
            "primary_preemptible_nodes"
        ],
        "Attributes": {
            "cluster": "google_container_cluster.primary.name",
            "location": "us-central1",
            "name": "my-node-pool",
            "node_count": "1"
        },
        "Blocks": [
            {
                "Type": "node_config",
                "Labels": [],
                "Attributes": {
                    "machine_type": "e2-medium",
                    "oauth_scopes": [
                        "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "preemptible": true,
                    "service_account": "google_service_account.default.email"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 36,
                    "startLine": 27
                }
            }
        ],
        "line_range": {
            "endLine": 37,
            "startLine": 21
        }
    }]
	count(result) == 1
}

test_google_container_cluster_alias_ip_enabled_failed {
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
            "initial_node_count": "1",
            "location": "us-central1",
            "name": "my-gke-cluster",
            "remove_default_node_pool": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 19,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_container_node_pool",
            "primary_preemptible_nodes"
        ],
        "Attributes": {
            "cluster": "google_container_cluster.primary.name",
            "location": "us-central1",
            "name": "my-node-pool",
            "node_count": "1"
        },
        "Blocks": [
            {
                "Type": "node_config",
                "Labels": [],
                "Attributes": {
                    "machine_type": "e2-medium",
                    "oauth_scopes": [
                        "https://www.googleapis.com/auth/cloud-platform"
                    ],
                    "preemptible": true,
                    "service_account": "google_service_account.default.email"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 36,
                    "startLine": 27
                }
            }
        ],
        "line_range": {
            "endLine": 37,
            "startLine": 21
        }
    }]
	count(result) == 1
}

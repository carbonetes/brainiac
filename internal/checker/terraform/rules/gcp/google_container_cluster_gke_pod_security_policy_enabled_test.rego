package lib.terraform.CB_TFGCP_013

test_google_container_cluster_gke_pod_security_policy_enabled_passed {
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
                "Type": "pod_security_policy_config",
                "Labels": [],
                "Attributes": {
                    "enabled": true
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
                    "endLine": 35,
                    "startLine": 26
                }
            }
        ],
        "line_range": {
            "endLine": 36,
            "startLine": 20
        }
    }]
	count(result) == 1
}

test_google_container_cluster_gke_pod_security_policy_enabled_failed {
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
            "endLine": 18,
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
                    "endLine": 35,
                    "startLine": 26
                }
            }
        ],
        "line_range": {
            "endLine": 36,
            "startLine": 20
        }
    }]
	count(result) == 1
}
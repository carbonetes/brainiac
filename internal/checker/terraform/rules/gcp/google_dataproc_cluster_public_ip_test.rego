package lib.terraform.CB_TFGCP_117

test_google_dataproc_cluster_public_ip_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "google"
        ],
        "Attributes": {
            "project": "<YOUR_PROJECT_ID>",
            "region": "us-central1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_dataproc_cluster",
            "example_cluster"
        ],
        "Attributes": {
            "labels": {
                "key": "value"
            },
            "name": "example-cluster",
            "project": "<YOUR_PROJECT_ID>",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "cluster_config",
                "Labels": [],
                "Attributes": {
                    "config_bucket": "example-config-bucket",
                    "initialization_actions": [
                        {
                            "executable_file": "gs://example-bucket/init-action.sh"
                        }
                    ]
                },
                "Blocks": [
                    {
                        "Type": "gce_cluster_config",
                        "Labels": [],
                        "Attributes": {
                            "internal_ip_only": true
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 22,
                            "startLine": 20
                        }
                    },
                    {
                        "Type": "master_config",
                        "Labels": [],
                        "Attributes": {
                            "machine_type": "n1-standard-4",
                            "num_instances": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 26,
                            "startLine": 23
                        }
                    },
                    {
                        "Type": "worker_config",
                        "Labels": [],
                        "Attributes": {
                            "machine_type": "n1-standard-4",
                            "num_instances": "2"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 30,
                            "startLine": 27
                        }
                    }
                ],
                "line_range": {
                    "endLine": 31,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 32,
            "startLine": 7
        }
    },
    {
        "Type": "output",
        "Labels": [
            "cluster_name"
        ],
        "Attributes": {
            "value": "google_dataproc_cluster.example_cluster.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 36,
            "startLine": 34
        }
    }]
	count(result) == 1
}

test_google_dataproc_cluster_public_ip_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "google"
        ],
        "Attributes": {
            "project": "<YOUR_PROJECT_ID>",
            "region": "us-central1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_dataproc_cluster",
            "example_cluster"
        ],
        "Attributes": {
            "labels": {
                "key": "value"
            },
            "name": "example-cluster",
            "project": "<YOUR_PROJECT_ID>",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "cluster_config",
                "Labels": [],
                "Attributes": {
                    "config_bucket": "example-config-bucket",
                    "initialization_actions": [
                        {
                            "executable_file": "gs://example-bucket/init-action.sh"
                        }
                    ]
                },
                "Blocks": [
                    {
                        "Type": "gce_cluster_config",
                        "Labels": [],
                        "Attributes": {
                            "internal_ip_only": false
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 22,
                            "startLine": 20
                        }
                    },
                    {
                        "Type": "master_config",
                        "Labels": [],
                        "Attributes": {
                            "machine_type": "n1-standard-4",
                            "num_instances": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 26,
                            "startLine": 23
                        }
                    },
                    {
                        "Type": "worker_config",
                        "Labels": [],
                        "Attributes": {
                            "machine_type": "n1-standard-4",
                            "num_instances": "2"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 30,
                            "startLine": 27
                        }
                    }
                ],
                "line_range": {
                    "endLine": 31,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 32,
            "startLine": 7
        }
    },
    {
        "Type": "output",
        "Labels": [
            "cluster_name"
        ],
        "Attributes": {
            "value": "google_dataproc_cluster.example_cluster.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 36,
            "startLine": 34
        }
    }]
	count(result) == 1
}

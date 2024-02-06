package lib.terraform.CB_TFRAN_060

test_rancher2_cluster_rke2_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "example_cluster"
        ],
        "Attributes": {
            "name": "example-cluster"
        },
        "Blocks": [
            {
                "Type": "rke2_config",
                "Labels": [],
                "Attributes": {
                    "version": "v1.22.5+k3s1"
                },
                "Blocks": [
                    {
                        "Type": "upgrade_strategy",
                        "Labels": [],
                        "Attributes": {
                            "draining_timeout": "30m",
                            "max_unavailable_control_plane_nodes": "1",
                            "max_unavailable_worker_nodes": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 10,
                            "startLine": 6
                        }
                    }
                ],
                "line_range": {
                    "endLine": 11,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 14,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_rke2_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo-custom"
        ],
        "Attributes": {
            "description": "Foo rancher2 custom cluster",
            "name": "foo-custom"
        },
        "Blocks": [
            {
                "Type": "rke2_config",
                "Labels": [],
                "Attributes": {
                    "version": "v1.22.5+k3s1"
                },
                "Blocks": [
                    {
                        "Type": "upgrade_strategy",
                        "Labels": [],
                        "Attributes": {
                            "draining_timeout": "30m",
                            "max_unavailable_control_plane_nodes": "1",
                            "max_unavailable_worker_nodes": "1"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 10,
                            "startLine": 6
                        }
                    }
                ],
                "line_range": {
                    "endLine": 11,
                    "startLine": 4
                }
            },
            {
                "Type": "aks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "rancher2_cloud_credential.foo-aks.id",
                    "imported": true,
                    "resource_group": "<RESOURCE_GROUP>",
                    "resource_location": "<RESOURCE_LOCATION>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 30,
                    "startLine": 25
                }
            }
        ],
        "line_range": {
            "endLine": 31,
            "startLine": 2
        }
    }]
    count(result) == 1
}

package lib.terraform.CB_TFRAN_067

test_rancher2_cluster_gke_config_v2_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "foo-google"
        ],
        "Attributes": {
            "description": "Terraform cloudCredential acceptance test",
            "name": "foo-google"
        },
        "Blocks": [
            {
                "Type": "google_credential_config",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 6,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform GKE cluster",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "gke_config_v2",
                "Labels": [],
                "Attributes": {
                    "google_credential_secret": "rancher2_cloud_credential.foo-google.id",
                    "kubernetes_version": "K8S_VERSION",
                    "name": "foo",
                    "network": "NETWORK",
                    "project_id": "PROJECT_ID",
                    "region": "REGION",
                    "subnetwork": "SUBNET"
                },
                "Blocks": [
                    {
                        "Type": "node_pools",
                        "Labels": [],
                        "Attributes": {
                            "initial_node_count": "1",
                            "max_pods_constraint": "110",
                            "name": "NODE_POOL_NAME",
                            "version": "VERSION"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 25,
                            "startLine": 20
                        }
                    }
                ],
                "line_range": {
                    "endLine": 26,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 27,
            "startLine": 9
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_gke_config_v2_failed {
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
                "Type": "gke_config_v2",
                "Labels": [],
                "Attributes": {
                    "google_credential_secret": "rancher2_cloud_credential.foo-google.id",
                    "kubernetes_version": "K8S_VERSION",
                    "name": "foo",
                    "network": "NETWORK",
                    "project_id": "PROJECT_ID",
                    "region": "REGION",
                    "subnetwork": "SUBNET"
                },
                "Blocks": [
                    {
                        "Type": "node_pools",
                        "Labels": [],
                        "Attributes": {
                            "initial_node_count": "1",
                            "max_pods_constraint": "110",
                            "name": "NODE_POOL_NAME",
                            "version": "VERSION"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 25,
                            "startLine": 20
                        }
                    }
                ],
                "line_range": {
                    "endLine": 26,
                    "startLine": 12
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
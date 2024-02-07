package lib.terraform.CB_TFRAN_063

test_rancher2_cluster_aks_config_v2_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "api_url": "https://rancher.example.com",
            "token": "your-api-token"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 2
        }
    },
    {
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
                "Type": "aks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "<cloud_credential_id>",
                    "imported": true,
                    "resource_group": "<resource_group>",
                    "resource_location": "<resource_location>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 20,
            "startLine": 9
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_aks_config_v2_failed {
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
                "Type": "aks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "<cloud_credential_id>",
                    "imported": true,
                    "resource_group": "<resource_group>",
                    "resource_location": "<resource_location>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 14
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
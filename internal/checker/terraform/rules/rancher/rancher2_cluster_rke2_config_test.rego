package lib.terraform.CB_TFRAN_060

test_rancher2_cluster_rke2_config_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "api_url": "https://your-rancher-server-url.com",
            "token_key": "your-api-token-key",
            "token_secret": "your-api-token-secret"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
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
                "Type": "rke2_config",
                "Labels": [],
                "Attributes": {
                    "update_strategy": "<update_strategy>",
                    "version": "v1.21.5+rke2r1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 28,
                    "startLine": 15
                }
            }
        ],
        "line_range": {
            "endLine": 31,
            "startLine": 10
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
                    "update_strategy": "<update_strategy>",
                    "version": "v1.21.5+rke2r1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 28,
                    "startLine": 15
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
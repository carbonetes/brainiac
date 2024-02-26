package lib.terraform.CB_TFRAN_134

test_rancher2_machine_config_v2_azure_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_machine_config_v2",
            "foo"
        ],
        "Attributes": {
            "generate_name": "test-foo"
        },
        "Blocks": [
            {
                "Type": "azure_config",
                "Labels": [],
                "Attributes": {
                    "client_id": "<AZURE_CLIENT_ID>",
                    "client_secret": "<AZURE_CLIENT_SECRET>",
                    "location": "<AZURE_LOCATION>",
                    "resource_group": "<AZURE_RESOURCE_GROUP>",
                    "storage_type": "<AZURE_STORAGE_TYPE>",
                    "subscription_id": "<AZURE_SUBSCRIPTION_ID>",
                    "tenant_id": "<AZURE_TENANT_ID>",
                    "vnet": "<AZURE_VNET_SUBNET_ID>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_machine_config_v2_azure_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_machine_config_v2",
            "foo"
        ],
        "Attributes": {
            "generate_name": "test-foo"
        },
        "Blocks": [
            {
                "Type": "azure_config",
                "Labels": [],
                "Attributes": {
                    "client_id": "<AZURE_CLIENT_ID>",
                    "client_secret": "<AZURE_CLIENT_SECRET>",
                    "location": "<AZURE_LOCATION>",
                    "resource_group": "<AZURE_RESOURCE_GROUP>",
                    "storage_type": "<AZURE_STORAGE_TYPE>",
                    "subscription_id": "<AZURE_SUBSCRIPTION_ID>",
                    "tenant_id": "<AZURE_TENANT_ID>",
                    "vnet": "<AZURE_VNET_SUBNET_ID>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 5
                }
            },
            {
                "Type": "digitalocean_config",
                "Labels": [],
                "Attributes": {
                    "access_token": "<DIGITALOCEAN_ACCESS_TOKEN>",
                    "backups": false,
                    "image": "<DIGITALOCEAN_IMAGE>",
                    "ipv6": false,
                    "monitoring": false,
                    "region": "<DIGITALOCEAN_REGION>",
                    "size": "<DIGITALOCEAN_SIZE>",
                    "ssh_key_fingerprint": "<DIGITALOCEAN_SSH_KEY_FINGERPRINT>",
                    "tags": [
                        "<TAG1>",
                        "<TAG2>"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 15,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 2
        }
    }]
    count(result) == 1
}
package lib.terraform.CB_TFRAN_050

test_rancher2_cloud_credential_azure_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "example"
        ],
        "Attributes": {
            "description": "Example Azure Cloud Credential",
            "name": "example-azure-credential"
        },
        "Blocks": [
            {
                "Type": "azure_credential_config",
                "Labels": [],
                "Attributes": {
                    "client_id": "<YOUR_AZURE_CLIENT_ID>",
                    "client_secret": "<YOUR_AZURE_CLIENT_SECRET>",
                    "subscription_id": "<YOUR_AZURE_SUBSCRIPTION_ID>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cloud_credential_azure_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "example"
        ],
        "Attributes": {
            "description": "Example Azure Cloud Credential",
            "name": "example-azure-credential"
        },
        "Blocks": [
            {
                "Type": "azure_credential_config",
                "Labels": [],
                "Attributes": {
                    "client_id": "<YOUR_AZURE_CLIENT_ID>",
                    "client_secret": "<YOUR_AZURE_CLIENT_SECRET>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
    count(result) == 1
}
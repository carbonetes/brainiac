package lib.terraform.CB_TFRAN_149

test_rancher2_node_template_azure_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Azure config for the Node Template",
            "name": "example-azure-config"
        },
        "Blocks": [
            {
                "Type": "azure_config",
                "Labels": [],
                "Attributes": {
                    "client_id": "<YOUR_AZURE_CLIENT_ID>",
                    "client_secret": "<YOUR_AZURE_CLIENT_SECRET>",
                    "subscription_id": "<YOUR_AZURE_SUBSCRIPTION_ID>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_node_template_azure_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Azure config for the Node Template",
            "name": "example-azure-config"
        },
        "Blocks": [
            {
                "Type": "azure_config",
                "Labels": [],
                "Attributes": {
                    "client_id": "",
                    "client_secret": "",
                    "subscription_id": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
    count(result) == 1
}
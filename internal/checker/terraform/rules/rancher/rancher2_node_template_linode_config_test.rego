package lib.terraform.CB_TFRAN_151

test_rancher2_node_template_linode_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Linode config for the Node Template",
            "name": "example-linode-config"
        },
        "Blocks": [
            {
                "Type": "linode_config",
                "Labels": [],
                "Attributes": {
                    "token": "your-linode-api-token"
                },
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
    }]
    count(result) == 1
}

test_rancher2_node_template_linode_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Linode config for the Node Template",
            "name": "example-linode-config"
        },
        "Blocks": [
            {
                "Type": "linode_config",
                "Labels": [],
                "Attributes": {
                    "token": ""
                },
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
    }]
    count(result) == 1
}
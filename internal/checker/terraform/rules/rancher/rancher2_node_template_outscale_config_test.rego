package lib.terraform.CB_TFRAN_156

test_rancher2_node_template_outscale_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Outscale config for the Node Template",
            "name": "example-outscale-config"
        },
        "Blocks": [
            {
                "Type": "outscale_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "<YOUR_OUTSCALE_ACCESS_KEY>",
                    "secret_key": "<YOUR_OUTSCALE_SECRET_KEY>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_node_template_outscale_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Outscale config for the Node Template",
            "name": "example-outscale-config"
        },
        "Blocks": [
            {
                "Type": "outscale_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "",
                    "secret_key": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
    count(result) == 1
}
package lib.terraform.CB_TFRAN_150

test_rancher2_node_template_digitalocean_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Digitalocean config for the Node Template",
            "name": "example-digitalocean-config"
        },
        "Blocks": [
            {
                "Type": "digitalocean_config",
                "Labels": [],
                "Attributes": {
                    "access_token": "<YOUR_DIGITALOCEAN_ACCESS_TOKEN>"
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

test_rancher2_node_template_digitalocean_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Digitalocean config for the Node Template",
            "name": "example-digitalocean-config"
        },
        "Blocks": [
            {
                "Type": "digitalocean_config",
                "Labels": [],
                "Attributes": {
                    "access_token": ""
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
package lib.terraform.CB_TFRAN_153

test_rancher2_node_template_hetzner_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "my_hetzner_node_template"
        ],
        "Attributes": {
            "driver_id": "rancher2_node_driver.hetzner_node_driver.id",
            "name": "my-hetzner-node-template"
        },
        "Blocks": [
            {
                "Type": "hetzner_config",
                "Labels": [],
                "Attributes": {
                    "api_token": "XXXXXXXXXX",
                    "image": "ubuntu-18.04",
                    "server_location": "nbg1",
                    "server_type": "cx11"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 4
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

test_rancher2_node_template_hetzner_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "my_hetzner_node_template"
        ],
        "Attributes": {
            "driver_id": "rancher2_node_driver.hetzner_node_driver.id",
            "name": "my-hetzner-node-template"
        },
        "Blocks": [
            {
                "Type": "hetzner_config",
                "Labels": [],
                "Attributes": {
                    "api_token": "",
                    "image": "ubuntu-18.04",
                    "server_location": "nbg1",
                    "server_type": "cx11"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 4
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
package lib.terraform.CB_TFRAN_154

test_rancher2_node_template_opennebula_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Opennebula config for the Node Template",
            "name": "example-opennebula-config"
        },
        "Blocks": [
            {
                "Type": "opennebula_config",
                "Labels": [],
                "Attributes": {
                    "password": "<YOUR_OPENNEBULA_PASSWORD>",
                    "user": "<YOUR_OPENNEBULA_USER>",
                    "xml_rpc_url": "<YOUR_OPENNEBULA_XML_RPC_URL>"
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

test_rancher2_node_template_opennebula_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Opennebula config for the Node Template",
            "name": "example-opennebula-config"
        },
        "Blocks": [
            {
                "Type": "opennebula_config",
                "Labels": [],
                "Attributes": {
                    "password": "",
                    "user": "",
                    "xml_rpc_url": ""
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
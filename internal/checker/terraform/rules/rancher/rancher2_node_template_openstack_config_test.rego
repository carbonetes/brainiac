package lib.terraform.CB_TFRAN_155

test_rancher2_node_template_openstack_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Openstack config for the Node Template",
            "name": "example-openstack-config"
        },
        "Blocks": [
            {
                "Type": "openstack_config",
                "Labels": [],
                "Attributes": {
                    "auth_url": "<YOUR_OPENSTACK_AUTH_URL>",
                    "availability_zone": "<YOUR_OPENSTACK_AVAILABILITY_ZONE>",
                    "region": "<YOUR_OPENSTACK_REGION>"
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

test_rancher2_node_template_openstack_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example Openstack config for the Node Template",
            "name": "example-openstack-config"
        },
        "Blocks": [
            {
                "Type": "openstack_config",
                "Labels": [],
                "Attributes": {
                    "auth_url": "",
                    "availability_zone": "",
                    "region": ""
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
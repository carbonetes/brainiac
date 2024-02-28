package lib.terraform.CB_TFRAN_157

test_rancher2_node_template_vsphere_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example VSphere config for the Node Template",
            "name": "example-vsphere-config"
        },
        "Blocks": [
            {
                "Type": "vsphere_config",
                "Labels": [],
                "Attributes": {
                    "password": "<VSphere_Password>",
                    "username": "<VSphere_Username>",
                    "vcenter": "<VSphere_IP_or_Hostname>"
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

test_rancher2_node_template_vsphere_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_template",
            "example"
        ],
        "Attributes": {
            "description": "Example VSphere config for the Node Template",
            "name": "example-vsphere-config"
        },
        "Blocks": [
            {
                "Type": "vsphere_config",
                "Labels": [],
                "Attributes": {
                    "password": "",
                    "username": "",
                    "vcenter": ""
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
package lib.terraform.CB_TFRAN_144

test_rancher2_node_driver_specified_attributes_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_driver",
            "foo"
        ],
        "Attributes": {
            "active": true,
            "builtin": false,
            "checksum": "0x0",
            "description": "Foo description",
            "external_id": "foo_external",
            "name": "foo",
            "ui_url": "https://ui",
            "url": "https://",
            "whitelist_domains": [
                "*.foo.com"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_node_driver_specified_attributes_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_node_driver",
            "foo"
        ],
        "Attributes": {
            "active": true,
            "builtin": false,
            "checksum": "",
            "description": "",
            "external_id": "",
            "name": "foo",
            "ui_url": "https://ui",
            "url": "https://",
            "whitelist_domains": []
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}
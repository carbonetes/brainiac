package lib.terraform.CB_TFRAN_116

test_rancher2_cluster_driver_checksum_whitelist_domains_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_driver",
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

test_rancher2_cluster_driver_checksum_whitelist_domains_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_driver",
            "foo"
        ],
        "Attributes": {
            "active": true,
            "builtin": false,
            "checksum": "",
            "description": "Foo description",
            "external_id": "foo_external",
            "name": "foo",
            "ui_url": "local://ui",
            "url": "local://",
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
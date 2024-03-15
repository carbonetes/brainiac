package lib.terraform.CB_TFRAN_115

test_rancher2_cluster_driver_https_urls_passed {
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

test_rancher2_cluster_driver_https_urls_failed {
    result := failed with input as [{
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
            "ui_url": "local://ui",
            "url": "local://",
            "actual_url" : "local://<actual_url>",
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
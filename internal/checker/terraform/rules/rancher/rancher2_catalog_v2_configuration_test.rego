package lib.terraform.CB_TFRAN_041

test_rancher2_catalog_v2_configuration_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog_v2",
            "foo-url"
        ],
        "Attributes": {
            "name": "foo-url",
            "url": "https://<CATALOG_URL>",
            "cluster_id": "<cluster_id>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 3
        }
    }]
    count(result) == 1
}

test_rancher2_catalog_v2_configuration_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog_v2",
            "foo-url"
        ],
        "Attributes": {
            "name": "foo-url",
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 3
        }
    }]
    count(result) == 1
}
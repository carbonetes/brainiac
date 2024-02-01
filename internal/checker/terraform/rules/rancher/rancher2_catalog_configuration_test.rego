package lib.terraform.CB_TFRAN_038

test_rancher2_catalog_configuration_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog",
            "foo-cluster"
        ],
        "Attributes": {
            "name": "foo-cluster",
            "scope": "cluster",
            "url": "https://<CATALOG_URL>",
            "branch": "master"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_catalog_configuration_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog",
            "foo-cluster"
        ],
        "Attributes": {
            "name": "foo-cluster",
            "scope": "cluster",
            "url": "https://<CATALOG_URL>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
    count(result) == 1
}
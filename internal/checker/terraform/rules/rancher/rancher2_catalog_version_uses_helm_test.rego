package lib.terraform.CB_TFRAN_039

test_rancher2_catalog_version_uses_helm_passed {
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
            "branch": "master",
            "version": "helm_v3"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_catalog_version_uses_helm_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog",
            "foo-cluster"
        ],
        "Attributes": {
            "name": "foo-cluster",
            "scope": "cluster",
            "url": "https://<CATALOG_URL>",
            "version": "not_helm_v3"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
    count(result) == 1
}
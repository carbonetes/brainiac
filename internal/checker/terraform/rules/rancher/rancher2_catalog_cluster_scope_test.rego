package lib.terraform.CB_TFRAN_037

test_rancher2_catalog_cluster_scope_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "rancher2_catalog",
            "foo-cluster"
        ],
        "Attributes": {
            "name": "foo-cluster",
            "scope": "cluster",
            "cluster_id": "<cluster_id>",
            "url": "https://<CATALOG_URL>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }
]
    count(result) == 1
}

test_rancher2_catalog_cluster_scope_failed {
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
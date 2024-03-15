package lib.terraform.CB_TFRAN_036

test_rancher2_catalog_project_scope_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog",
            "foo-project"
        ],
        "Attributes": {
            "name": "foo-project",
            "scope": "project",
            "url": "https://<CATALOG_URL>",
            "project_id": "<project_id>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 3
        }
    }]
    count(result) == 1
}

test_rancher2_catalog_project_scope_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog",
            "foo-project"
        ],
        "Attributes": {
            "name": "foo-project",
            "scope": "project",
            "url": "https://<CATALOG_URL>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 3
        }
    }]
    count(result) == 1
}
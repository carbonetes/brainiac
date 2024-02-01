package lib.terraform.CB_TFRAN_042

test_rancher2_catalog_v2_git_validation_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog_v2",
            "foo-url"
        ],
        "Attributes": {
            "name": "foo-url",
            "git_repo": "<git_repo>",
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 3
        }
    }]
    count(result) == 1
}

test_rancher2_catalog_v2_url_validation_passed {
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

test_rancher2_catalog_v2_git_url_validation_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog_v2",
            "foo-url"
        ],
        "Attributes": {
            "name": "foo-url",
            "url": "https://<CATALOG_URL>",
            "git_repo": "<git_repo>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 3
        }
    }]
    count(result) == 1
}
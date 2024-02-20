package lib.terraform.CB_TFRAN_043

test_rancher2_catalog_v2_secrets_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog_v2",
            "foo-url"
        ],
        "Attributes": {
            "name": "foo-url",
            "git_repo": "<git_repo>",
            "secret_name": "<secret>",
            "name_space": "<name_space>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 3
        }
    }]
    count(result) == 1
}

test_rancher2_catalog_v2_secrets_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_catalog_v2",
            "foo-url"
        ],
        "Attributes": {
            "name": "foo-url",
            "url": "https://<CATALOG_URL>",
            "secret_name": "<secret>",
            "secret_namespace": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 3
        }
    }]
    count(result) == 1
}
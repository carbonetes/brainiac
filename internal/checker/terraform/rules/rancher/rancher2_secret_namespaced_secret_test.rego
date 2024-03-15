package lib.terraform.CB_TFRAN_183

test_rancher2_secret_namespaced_secret_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_secret",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform secret foo",
            "name": "foo",
            "namespace_id": "<namespace_id>",
            "project_id": "<project_id>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_secret_namespaced_secret_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_secret",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform secret foo",
            "name": "foo",
            "namespace_id": "",
            "project_id": "<project_id>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}
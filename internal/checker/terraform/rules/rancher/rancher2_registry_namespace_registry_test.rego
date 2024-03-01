package lib.terraform.CB_TFRAN_180

test_rancher2_registry_namespace_registry_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_registry",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform registry foo",
            "name": "foo",
            "namespace_id": "<namespace_id>",
            "project_id": "<project_id>"
        },
        "Blocks": [
            {
                "Type": "registries",
                "Labels": [],
                "Attributes": {
                    "address": "test.io",
                    "password": "pass",
                    "username": "user2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_registry_namespace_registry_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_registry",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform registry foo",
            "name": "foo",
            "namespace_id": "",
            "project_id": "<project_id>"
        },
        "Blocks": [
            {
                "Type": "registries",
                "Labels": [],
                "Attributes": {
                    "address": "test.io",
                    "password": "pass",
                    "username": "user2"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}
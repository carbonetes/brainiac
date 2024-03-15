package lib.terraform.CB_TFRAN_097

test_rancher2_registry_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_registry",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform registry foo",
            "name": "foo",
            "project_id": "<project_id>"
        },
        "Blocks": [
            {
                "Type": "registries",
                "Labels": [],
                "Attributes": {
                    "address": "test.io",
                    "password": "pass",
                    "username": "user"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_registry_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_registry",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform registry foo",
            "name": "",
            "project_id": ""
        },
        "Blocks": [
            {
                "Type": "registries",
                "Labels": [],
                "Attributes": {
                    "address": "test.io",
                    "password": "pass",
                    "username": "user"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
    count(result) == 1
}
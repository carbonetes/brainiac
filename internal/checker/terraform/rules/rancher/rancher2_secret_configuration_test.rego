package lib.terraform.CB_TFRAN_099

test_rancher2_secret_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_secret",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform secret foo",
            "name": "foo",
            "project_id": "<project_id>",
            "data": {
                "address": "dGVzdC5pbw==",
                "username": "dXNlcjI=",
                "password": "cGFzcw=="
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_secret_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_secret",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform secret foo",
            "name": "foo",
            "project_id": "",
            "data": {}
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
    count(result) == 1
}
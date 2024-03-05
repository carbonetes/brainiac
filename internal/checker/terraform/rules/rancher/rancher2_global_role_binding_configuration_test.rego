package lib.terraform.CB_TFRAN_084

test_rancher2_global_role_binding_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_role_binding",
            "foo"
        ],
        "Attributes": {
            "global_role_id": "admin",
            "name": "foo",
            "user_id": "user-XXXXX"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_global_role_binding_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_role_binding",
            "foo"
        ],
        "Attributes": {
            "global_role_id": "",
            "name": "foo",
            "user_id": "user-XXXXX"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 2
        }
    }]
    count(result) == 1
}
package lib.terraform.CB_TFRAN_131

test_rancher2_global_role_binding_group_principal_id_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_role_binding",
            "foo2"
        ],
        "Attributes": {
            "global_role_id": "admin",
            "group_principal_id": "local://g-XXXXX",
            "name": "foo2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_global_role_binding_group_principal_id_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_role_binding",
            "foo2"
        ],
        "Attributes": {
            "global_role_id": "admin",
            "group_principal_id": "",
            "name": "foo2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 2
        }
    }]
    count(result) == 1
}
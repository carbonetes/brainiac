package lib.terraform.CB_TFRAN_179

test_rancher2_project_role_template_binding_user_group_id_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_role_template_binding",
            "foo"
        ],
        "Attributes": {
            "group_id": "<group_id>",
            "group_principal_id": "<group_principal_id>",
            "name": "foo",
            "project_id": "<project_id>",
            "role_template_id": "<role_template_id>",
            "user_id": "<user_id>",
            "user_principal_id": "<user_principal_id>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_project_role_template_binding_user_group_id_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_role_template_binding",
            "foo"
        ],
        "Attributes": {
            "group_id": "",
            "group_principal_id": "",
            "name": "foo",
            "project_id": "<project_id>",
            "role_template_id": "<role_template_id>",
            "user_id": "",
            "user_principal_id": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}
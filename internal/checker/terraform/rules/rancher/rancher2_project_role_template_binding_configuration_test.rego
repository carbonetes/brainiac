package lib.terraform.CB_TFRAN_096

test_rancher2_project_role_template_binding_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_role_template_binding",
            "foo"
        ],
        "Attributes": {
            "name": "foo",
            "project_id": "<project_id>",
            "role_template_id": "<role_template_id>",
            "user_id": "<user_id>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_project_role_template_binding_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_role_template_binding",
            "foo"
        ],
        "Attributes": {
            "name": "",
            "project_id": "",
            "role_template_id": "",
            "user_id": "<user_id>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 2
        }
    }]
    count(result) == 1
}
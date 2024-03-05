package lib.terraform.CB_TFRAN_073

test_rancher2_cluster_role_template_binding_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_role_template_binding",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "name": "foo",
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

test_rancher2_cluster_role_template_binding_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_role_template_binding",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "name": "foo",
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
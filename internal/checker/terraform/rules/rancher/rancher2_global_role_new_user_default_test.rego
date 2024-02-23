package lib.terraform.CB_TFRAN_130

test_rancher2_global_role_new_user_default_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_role",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform global role acceptance test",
            "name": "foo",
            "new_user_default": false
        },
        "Blocks": [
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "api_groups": [
                        "*"
                    ],
                    "resources": [
                        "secrets"
                    ],
                    "verbs": [
                        "create"
                    ]
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

test_rancher2_global_role_new_user_default_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_global_role",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform global role acceptance test",
            "name": "foo",
            "new_user_default": true
        },
        "Blocks": [
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "api_groups": [
                        "*"
                    ],
                    "resources": [
                        "secrets"
                    ],
                    "verbs": [
                        "create"
                    ]
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
package lib.terraform.CB_TFRAN_182

test_rancher2_role_template_rules_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_role_template",
            "foo"
        ],
        "Attributes": {
            "context": "cluster",
            "default_role": true,
            "description": "Terraform role template acceptance test",
            "name": "foo"
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

test_rancher2_role_template_rules_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_role_template",
            "foo"
        ],
        "Attributes": {
            "context": "cluster",
            "default_role": true,
            "description": "Terraform role template acceptance test",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "api_groups": [],
                    "resources": [],
                    "verbs": [
                        "not_included"
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
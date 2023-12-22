package lib.terraform.CB_TFK8S_033

test_kubernetes_cluster_role_wild_card_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_role",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "example-role",
                    "namespace": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 5,
                    "startLine": 2
                }
            },
            {
                "Type": "rule",
                "Labels": [],
                "Attributes": {
                    "api_groups": [
                        "pods"
                    ],
                    "resources": [
                        "pods"
                    ],
                    "verbs": [
                        "get",
                        "list",
                        "watch"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 7
                }
            },
            {
                "Type": "rule",
                "Labels": [],
                "Attributes": {
                    "api_groups": [
                        "extensions"
                    ],
                    "resources": [
                        "deployments"
                    ],
                    "verbs": [
                        "get",
                        "list",
                        "watch",
                        "create",
                        "update",
                        "patch",
                        "delete"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_kubernetes_cluster_role_wild_card_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_role",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "example-role",
                    "namespace": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 5,
                    "startLine": 2
                }
            },
            {
                "Type": "rule",
                "Labels": [],
                "Attributes": {
                    "api_groups": [
                        ""
                    ],
                    "resources": [
                        "pods"
                    ],
                    "verbs": [
                        "get",
                        "list",
                        "watch"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 7
                }
            },
            {
                "Type": "rule",
                "Labels": [],
                "Attributes": {
                    "api_groups": [
                        "extensions"
                    ],
                    "resources": [
                        "deployments"
                    ],
                    "verbs": [
                        "get",
                        "list",
                        "watch",
                        "create",
                        "update",
                        "patch",
                        "delete"
                    ]
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 18,
            "startLine": 1
        }
    }]
	count(result) == 1
}
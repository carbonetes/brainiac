package lib.terraform.CB_TFRAN_109

test_rancher2_multi_cluster_app_targets_configuration_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_multi_cluster_app",
            "foo"
        ],
        "Attributes": {
            "catalog_name": "<catalog_name>",
            "name": "foo",
            "roles": [
                "project-member"
            ],
            "template_name": "<template_name>",
            "template_version": "<template_version>"
        },
        "Blocks": [
            {
                "Type": "targets",
                "Labels": [],
                "Attributes": {
                    "project_id": "<project_id>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            },
            {
                "Type": "answers",
                "Labels": [],
                "Attributes": {
                    "values": {
                        "ingress_host": "test.xip.io"
                    }
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 10
                }
            }
        ],
        "line_range": {
            "endLine": 16,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_multi_cluster_app_targets_configuration_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_multi_cluster_app",
            "foo"
        ],
        "Attributes": {
            "catalog_name": "<catalog_name>",
            "name": "foo",
            "roles": [
                "project-member"
            ],
            "template_name": "<template_name>",
            "template_version": "<template_version>"
        },
        "Blocks": [
            {
                "Type": "targets",
                "Labels": [],
                "Attributes": {
                    "project_id": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            },
            {
                "Type": "answers",
                "Labels": [],
                "Attributes": {
                    "values": {
                        "ingress_host": "test.xip.io"
                    }
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 10
                }
            }
        ],
        "line_range": {
            "endLine": 16,
            "startLine": 2
        }
    }]
    count(result) == 1
}
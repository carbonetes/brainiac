package lib.terraform.CB_TFRAN_142

test_rancher2_namespace_resource_quota_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_namespace",
            "foo"
        ],
        "Attributes": {
            "description": "foo namespace",
            "name": "foo",
            "project_id": "<PROJECT_ID>"
        },
        "Blocks": [
            {
                "Type": "resource_quota",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "limit",
                        "Labels": [],
                        "Attributes": {
                            "limits_cpu": "100m",
                            "limits_memory": "100Mi",
                            "requests_storage": "1Gi"
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
                    "startLine": 6
                }
            },
            {
                "Type": "container_resource_limit",
                "Labels": [],
                "Attributes": {
                    "limits_cpu": "20m",
                    "limits_memory": "20Mi",
                    "requests_cpu": "1m",
                    "requests_memory": "1Mi"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_namespace_resource_quota_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_namespace",
            "foo"
        ],
        "Attributes": {
            "description": "foo namespace",
            "name": "foo",
            "project_id": "<PROJECT_ID>"
        },
        "Blocks": [
            {
                "Type": "resource_quota",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "no_limit",
                        "Labels": [],
                        "Attributes": {
                            "limits_cpu": "100m",
                            "limits_memory": "100Mi",
                            "requests_storage": "1Gi"
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
                    "startLine": 6
                }
            },
            {
                "Type": "container_resource_limit",
                "Labels": [],
                "Attributes": {
                    "limits_cpu": "20m",
                    "limits_memory": "20Mi",
                    "requests_cpu": "1m",
                    "requests_memory": "1Mi"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 2
        }
    }]
    count(result) == 1
}
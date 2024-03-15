package lib.terraform.CB_TFRAN_174

test_rancher2_project_container_resource_limit_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<CLUSTER_ID>",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "resource_quota",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "project_limit",
                        "Labels": [],
                        "Attributes": {
                            "limits_cpu": "2000m",
                            "limits_memory": "2000Mi",
                            "requests_storage": "2Gi"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 10,
                            "startLine": 6
                        }
                    },
                    {
                        "Type": "namespace_default_limit",
                        "Labels": [],
                        "Attributes": {
                            "limits_cpu": "2000m",
                            "limits_memory": "500Mi",
                            "requests_storage": "1Gi"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 15,
                            "startLine": 11
                        }
                    }
                ],
                "line_range": {
                    "endLine": 16,
                    "startLine": 5
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
                    "endLine": 22,
                    "startLine": 17
                }
            }
        ],
        "line_range": {
            "endLine": 23,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_project_container_resource_limit_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<CLUSTER_ID>",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "resource_quota",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "project_limit",
                        "Labels": [],
                        "Attributes": {
                            "limits_cpu": "2000m",
                            "limits_memory": "2000Mi",
                            "requests_storage": "2Gi"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 10,
                            "startLine": 6
                        }
                    },
                    {
                        "Type": "namespace_default_limit",
                        "Labels": [],
                        "Attributes": {
                            "limits_cpu": "2000m",
                            "limits_memory": "500Mi",
                            "requests_storage": "1Gi"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 15,
                            "startLine": 11
                        }
                    }
                ],
                "line_range": {
                    "endLine": 16,
                    "startLine": 5
                }
            },
            {
                "Type": "container_resource_limit",
                "Labels": [],
                "Attributes": {
                    "limits_cpu": "",
                    "limits_memory": "",
                    "requests_cpu": "",
                    "requests_memory": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 22,
                    "startLine": 17
                }
            }
        ],
        "line_range": {
            "endLine": 23,
            "startLine": 2
        }
    }]
    count(result) == 1
}
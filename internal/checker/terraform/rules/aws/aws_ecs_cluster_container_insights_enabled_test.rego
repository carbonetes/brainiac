package lib.terraform.CB_TFAWS_060
import rego.v1

test_aws_ecs_cluster_container_insights_enabled_passed if {
    result := passed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ecs_cluster",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "setting",
                                        "Labels": [],
                                        "Attributes": {
                                        "name": "containerInsights",
                                        "value": "enabled"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 6,
                                        "startLine": 3
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 7,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_ecs_cluster_container_insights_enabled_failed if {
result := failed with input as [
                                     {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ecs_cluster",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "setting",
                                        "Labels": [],
                                        "Attributes": {
                                        "name": "n",
                                        "value": "n"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 6,
                                        "startLine": 3
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 7,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

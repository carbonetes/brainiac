package lib.terraform.CB_TFAWS_072
import rego.v1

test_aws_ecs_task_definition_transit_encryption_enabled_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ecs_task_definition",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "volume",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "efs_volume_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "transit_encryption": "ENABLED"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 7,
                                        "startLine": 5
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 8,
                                        "startLine": 4
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 9,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_ecs_task_definition_transit_encryption_enabled_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ecs_task_definition",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "volume",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "efs_volume_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "transit_encryption": "DISABLED"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 7,
                                        "startLine": 5
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 8,
                                        "startLine": 4
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 9,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

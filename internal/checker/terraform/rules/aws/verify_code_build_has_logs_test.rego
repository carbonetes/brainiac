package lib.terraform.CB_TFAWS_301

import rego.v1 

test_verify_code_build_has_logs_passed if {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_codebuild_project",
                "example_project"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "logs_config",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [
                        {
                            "Type": "cloudwatch_logs",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [],
                            "line_range": {
                                "endLine": 4,
                                "startLine": 3
                            }
                        },
                        {
                            "Type": "s3_logs",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [],
                            "line_range": {
                                "endLine": 7,
                                "startLine": 6
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 8,
                        "startLine": 2
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

test_verify_code_build_has_logs_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_codebuild_project",
                "example_project"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "logs_config",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [
                        {
                            "Type": "test_logs",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [],
                            "line_range": {
                                "endLine": 4,
                                "startLine": 3
                            }
                        },
                        {
                            "Type": "tc_logs",
                            "Labels": [],
                            "Attributes": {},
                            "Blocks": [],
                            "line_range": {
                                "endLine": 7,
                                "startLine": 6
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 8,
                        "startLine": 2
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
package lib.terraform.CB_TFAWS_302

import rego.v1 

test_verify_aws_codebuild_project_privileged_mode_disabled if {
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
                    "Type": "environment",
                    "Labels": [],
                    "Attributes": {
                        "privileged_mode": false
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 4,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 5,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}

test_verify_aws_codebuild_project_privileged_mode_enabled if {
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
                    "Type": "environment",
                    "Labels": [],
                    "Attributes": {
                        "privileged_mode": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 4,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 5,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}
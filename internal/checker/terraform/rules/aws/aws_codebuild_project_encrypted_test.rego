package lib.terraform.CB_TFAWS_122
import rego.v1

test_aws_codebuild_project_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_codebuild_project",
                        "example_project"
                        ],
                        "Attributes": {
                        "encryption_key": "example-key-id",
                        "name": "example-project"
                        },
                        "Blocks": [
                        {
                            "Type": "artifacts",
                            "Labels": [],
                            "Attributes": {
                            "encryption_disabled": false,
                            "type": "S3"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 8,
                            "startLine": 4
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 13,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_codebuild_project_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_codebuild_project",
                        "example_project"
                        ],
                        "Attributes": {
                        "name": "example-project"
                        },
                        "Blocks": [
                        {
                            "Type": "artifacts",
                            "Labels": [],
                            "Attributes": {
                            "encryption_disabled": false,
                            "type": "S3"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 8,
                            "startLine": 4
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 13,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}
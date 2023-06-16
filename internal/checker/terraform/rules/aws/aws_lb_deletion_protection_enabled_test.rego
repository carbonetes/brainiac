package lib.terraform.CB_TFAWS_129

test_aws_codebuild_project_passed {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_lb",
                        "test_success"
                        ],
                        "Attributes": {
                        "enable_deletion_protection": true
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 4,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_codebuild_project_failed {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_lb",
                        "test_success"
                        ],
                        "Attributes": {
                        "enable_deletion_protection": true
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 4,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}
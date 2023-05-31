package lib.terraform.CB_TFAWS_066

test_cloudwatch_log_group_has_retention {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_cloudwatch_log_group",
                            "example"
                            ],
                            "Attributes": {
                            "name": "example",
                            "retention_in_days": "90"
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

test_cloudwatch_log_group_no_retention {
    result := failed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_cloudwatch_log_group",
                            "example"
                            ],
                            "Attributes": {
                            "name": "example"
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
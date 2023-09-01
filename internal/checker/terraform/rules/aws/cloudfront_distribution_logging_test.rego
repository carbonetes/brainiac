package lib.terraform.CB_TFAWS_092

test_cloudfront_distribution_logging_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_cloudfront_distribution",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "logging_config",
                                        "Labels": [],
                                        "Attributes": {
                                        "bucket": "example-logs-bucket"
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

test_cloudfront_distribution_logging_failed {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_cloudfront_distribution",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "logging_config",
                                        "Labels": [],
                                        "Attributes": {
                                        "tc": "example-logs-bucket"
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
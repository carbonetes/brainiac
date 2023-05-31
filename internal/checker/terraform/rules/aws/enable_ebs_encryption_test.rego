package lib.terraform.CB_TFAWS_003

test_enable_ebs_encryption_passed {
    result := passed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_ebs_volume",
                                        "example"
                                    ],
                                    "Attributes": {
                                        "deletion_window_in_days": "30",
                                        "description": "Example key for testing",
                                        "encrypted": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 50,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}

test_enable_ebs_encryption_faied {
result := failed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_ebs_volume",
                                        "example"
                                    ],
                                    "Attributes": {
                                        "deletion_window_in_days": "30",
                                        "description": "Example key for testing",
                                        "encrypted": false
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 50,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}
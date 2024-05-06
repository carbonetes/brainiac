package lib.terraform.CB_TFAWS_127
import rego.v1

test_enable_ecr_repository_encryption_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ecr_repository",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "name": "bar"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "encryption_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "encryption_type": "KMS"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 5,
                                        "startLine": 3
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_enable_ecr_repository_encryption_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ecr_repository",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "name": "bar"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "encryption_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "encryption_type": "test case"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 5,
                                        "startLine": 3
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}
package lib.terraform.CB_TFAWS_155
import rego.v1

test_aws_ecr_repository_ecr_image_scanning_on_push_enabled_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ecr_repository",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "image_tag_mutability": "MUTABLE"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "image_scanning_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "scan_on_push": true
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 6,
                                        "startLine": 4
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 8,
                                    "startLine": 1
                                    }
                                    }
                                    ]
                                    
    count(result) == 1
}

test_aws_ecr_repository_ecr_image_scanning_on_push_enabled_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ecr_repository",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "image_tag_mutability": "MUTABLE"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "image_scanning_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "scan_on_push": false
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 6,
                                        "startLine": 4
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 8,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}
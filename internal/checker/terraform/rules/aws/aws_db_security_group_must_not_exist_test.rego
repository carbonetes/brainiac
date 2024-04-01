package lib.terraform.CB_TFAWS_189
import rego.v1

test_aws_db_security_group_must_not_exist_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_other_resource",
                        "exists"
                        ],
                        "Attributes": {
                        "name": "rds_sg"
                        },
                        "Blocks": [
                        {
                            "Type": "ingress",
                            "Labels": [],
                            "Attributes": {
                            "cidr": "10.0.0.0/24"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 6,
                            "startLine": 4
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 7,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 0
}

test_aws_db_security_group_must_not_exist_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_db_security_group",
                        "exists"
                        ],
                        "Attributes": {
                        "name": "rds_sg"
                        },
                        "Blocks": [
                        {
                            "Type": "ingress",
                            "Labels": [],
                            "Attributes": {
                            "cidr": "10.0.0.0/24"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 6,
                            "startLine": 4
                            }
                        }
                        ],
                        "line_range": {
                        "endLine": 7,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}
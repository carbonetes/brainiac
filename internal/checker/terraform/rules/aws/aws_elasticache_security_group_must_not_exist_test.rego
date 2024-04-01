package lib.terraform.CB_TFAWS_187
import rego.v1

test_aws_elasticache_security_group_must_not_exist_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_other_resource",
                        "exists"
                        ],
                        "Attributes": {
                        "name": "elasticache-security-group",
                        "security_group_names": "aws_security_group.bar.name"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 4,
                        "startLine": 1
                        }
                        },
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_security_group",
                        "bar"
                        ],
                        "Attributes": {
                        "name": "security-group"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 8,
                        "startLine": 6
                        }
                        }
                        ]
    count(result) == 0
}

test_aws_elasticache_security_group_must_not_exist_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_elasticache_security_group",
                        "exists"
                        ],
                        "Attributes": {
                        "name": "elasticache-security-group",
                        "security_group_names": "aws_security_group.bar.name"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 4,
                        "startLine": 1
                        }
                        },
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_security_group",
                        "bar"
                        ],
                        "Attributes": {
                        "name": "security-group"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 8,
                        "startLine": 6
                        }
                        }
                        ]
    count(result) == 1
}
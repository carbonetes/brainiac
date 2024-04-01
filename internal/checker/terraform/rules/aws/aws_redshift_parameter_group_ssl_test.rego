package lib.terraform.CB_TFAWS_101
import rego.v1

test_aws_redshift_parameter_group_ssl_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_redshift_parameter_group",
                                "example"
                                ],
                                "Attributes": {},
                                "Blocks": [
                                {
                                    "Type": "parameter",
                                    "Labels": [],
                                    "Attributes": {
                                    "name": "require_ssl",
                                    "value": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 2
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

test_aws_redshift_parameter_group_ssl_failed if {
result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_redshift_parameter_group",
                                "example"
                                ],
                                "Attributes": {},
                                "Blocks": [
                                {
                                    "Type": "parameter",
                                    "Labels": [],
                                    "Attributes": {
                                    "name": "require_ssl",
                                    "value": false
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 2
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
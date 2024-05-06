package lib.terraform.CB_TFAWS_074
import rego.v1

test_cloudfront_waf_is_set if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_cloudfront_distribution",
                                "exapmle"
                                ],
                                "Attributes": {
                                "enabled": true,
                                "is_ipv6_enabled": false,
                                "web_acl_id": "aws_wafv2_web_acl.example.id"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 7,
                                "startLine": 1
                                }
                            }
                        ]
    count(result) == 1
}

test_cloudfront_waf_not_set if {
    result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_cloudfront_distribution",
                                "exapmle"
                                ],
                                "Attributes": {
                                "enabled": true,
                                "is_ipv6_enabled": false
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 7,
                                "startLine": 1
                                }
                            }
                        ]
    count(result) == 1
}
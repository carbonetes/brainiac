package lib.terraform.CB_TFAWS_166
import rego.v1

test_aws_cloudfront_distribution_cloudfront_distribution_viewer_certificate_utilizing_tls_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_cloudfront_distribution",
                        "pass"
                        ],
                        "Attributes": {},
                        "Blocks": [
                        {
                            "Type": "viewer_certificate",
                            "Labels": [],
                            "Attributes": {
                            "cloudfront_default_certificate": false,
                            "minimum_protocol_version": "TLSv1.2_2018"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 6,
                            "startLine": 3
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

test_aws_cloudfront_distribution_cloudfront_distribution_viewer_certificate_utilizing_tls_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_cloudfront_distribution",
                        "pass"
                        ],
                        "Attributes": {},
                        "Blocks": [
                        {
                            "Type": "viewer_certificate",
                            "Labels": [],
                            "Attributes": {
                            "cloudfront_default_certificate": false,
                            "minimum_protocol_version": "TLSv1"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 6,
                            "startLine": 3
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
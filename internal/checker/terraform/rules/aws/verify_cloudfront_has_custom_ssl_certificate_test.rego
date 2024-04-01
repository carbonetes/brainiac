package lib.terraform.CB_TFAWS_324

import rego.v1 

test_cloudfront_has_custom_ssl_certificate_passed if {
	result := passed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-west-2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_acm_certificate",
            "example_certificate"
        ],
        "Attributes": {
            "domain_name": "example.com",
            "validation_method": "DNS"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_cloudfront_distribution",
            "example_distribution"
        ],
        "Attributes": {
            "comment": "Example CloudFront Distribution",
            "enabled": true,
            "http_version": "http2",
            "is_ipv6_enabled": true,
            "price_class": "PriceClass_100"
        },
        "Blocks": [
            {
                "Type": "origin",
                "Labels": [],
                "Attributes": {
                    "domain_name": "example-origin.com",
                    "origin_id": "example-origin"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            },
            {
                "Type": "default_cache_behavior",
                "Labels": [],
                "Attributes": {
                    "allowed_methods": [
                        "GET",
                        "HEAD",
                        "OPTIONS"
                    ],
                    "cached_methods": [
                        "GET",
                        "HEAD"
                    ],
                    "target_origin_id": "example-origin"
                },
                "Blocks": [
                    {
                        "Type": "forwarded_values",
                        "Labels": [],
                        "Attributes": {
                            "query_string": false
                        },
                        "Blocks": [
                            {
                                "Type": "cookies",
                                "Labels": [],
                                "Attributes": {
                                    "forward": "none"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 29,
                                    "startLine": 27
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 30,
                            "startLine": 25
                        }
                    }
                ],
                "line_range": {
                    "endLine": 31,
                    "startLine": 21
                }
            },
            {
                "Type": "restrictions",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "geo_restriction",
                        "Labels": [],
                        "Attributes": {
                            "restriction_type": "none"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 36,
                            "startLine": 34
                        }
                    }
                ],
                "line_range": {
                    "endLine": 37,
                    "startLine": 33
                }
            },
            {
                "Type": "viewer_certificate",
                "Labels": [],
                "Attributes": {
                    "acm_certificate_arn": "aws_acm_certificate.example_certificate.arn",
                    "minimum_protocol_version": "TLSv1.2_2018",
                    "ssl_support_method": "sni-only"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 43,
                    "startLine": 39
                }
            }
        ],
        "line_range": {
            "endLine": 44,
            "startLine": 10
        }
    }
]
	count(result) == 1
}

test_cloudfront_has_custom_ssl_certificate_failed if {
	result := failed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-west-2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_acm_certificate",
            "example_certificate"
        ],
        "Attributes": {
            "domain_name": "example.com",
            "validation_method": "DNS"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_cloudfront_distribution",
            "example_distribution"
        ],
        "Attributes": {
            "comment": "Example CloudFront Distribution",
            "enabled": true,
            "http_version": "http2",
            "is_ipv6_enabled": true,
            "price_class": "PriceClass_100"
        },
        "Blocks": [
            {
                "Type": "origin",
                "Labels": [],
                "Attributes": {
                    "domain_name": "example-origin.com",
                    "origin_id": "example-origin"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            },
            {
                "Type": "default_cache_behavior",
                "Labels": [],
                "Attributes": {
                    "allowed_methods": [
                        "GET",
                        "HEAD",
                        "OPTIONS"
                    ],
                    "cached_methods": [
                        "GET",
                        "HEAD"
                    ],
                    "target_origin_id": "example-origin"
                },
                "Blocks": [
                    {
                        "Type": "forwarded_values",
                        "Labels": [],
                        "Attributes": {
                            "query_string": false
                        },
                        "Blocks": [
                            {
                                "Type": "cookies",
                                "Labels": [],
                                "Attributes": {
                                    "forward": "none"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 29,
                                    "startLine": 27
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 30,
                            "startLine": 25
                        }
                    }
                ],
                "line_range": {
                    "endLine": 31,
                    "startLine": 21
                }
            },
            {
                "Type": "restrictions",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "geo_restriction",
                        "Labels": [],
                        "Attributes": {
                            "restriction_type": "none"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 36,
                            "startLine": 34
                        }
                    }
                ],
                "line_range": {
                    "endLine": 37,
                    "startLine": 33
                }
            },
            {
                "Type": "viewer_certificate",
                "Labels": [],
                "Attributes": {
                    "minimum_protocol_version": "TLSv1.2_2018",
                    "ssl_support_method": "sni-only"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 43,
                    "startLine": 39
                }
            }
        ],
        "line_range": {
            "endLine": 44,
            "startLine": 10
        }
    }
]
	count(result) == 1
}
package lib.terraform.CB_TFAWS_345

import rego.v1 

test_aws_cloudfront_s3_origin_config_with_oai_passed if {
	result := passed with input as [
    {
        "Attributes": {
            "bucket": "mybucket",
            "tags": {
                "Name": "My bucket"
            }
        },
        "Blocks": [],
        "Labels": [
            "aws_s3_bucket",
            "b"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "aliases": [
                "mysite.example.com",
                "yoursite.example.com"
            ],
            "comment": "Some comment",
            "default_root_object": "index.html",
            "enabled": true,
            "is_ipv6_enabled": true,
            "price_class": "PriceClass_200",
            "tags": {
                "Environment": "production"
            },
            "web_acl_id": "aws_wafv2_web_acl.example.arn"
        },
        "Blocks": [
            {
                "Attributes": {
                    "domain_name": "aws_s3_bucket.b.bucket_regional_domain_name",
                    "origin_id": "failoverS3"
                },
                "Blocks": [
                    {
                        "Attributes": {
                            "origin_access_identity": "aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path"
                        },
                        "Blocks": [],
                        "Labels": [],
                        "Type": "s3_origin_config",
                        "line_range": {
                            "endLine": 17,
                            "startLine": 15
                        }
                    }
                ],
                "Labels": [],
                "Type": "origin",
                "line_range": {
                    "endLine": 19,
                    "startLine": 12
                }
            },
            {
                "Attributes": {
                    "bucket": "mylogs.s3.amazonaws.com",
                    "include_cookies": false,
                    "prefix": "myprefix"
                },
                "Blocks": [],
                "Labels": [],
                "Type": "logging_config",
                "line_range": {
                    "endLine": 33,
                    "startLine": 29
                }
            },
            {
                "Attributes": {
                    "allowed_methods": [
                        "DELETE",
                        "GET",
                        "HEAD",
                        "OPTIONS",
                        "PATCH",
                        "POST",
                        "PUT"
                    ],
                    "cached_methods": [
                        "GET",
                        "HEAD"
                    ],
                    "default_ttl": "3600",
                    "max_ttl": "86400",
                    "min_ttl": "0",
                    "target_origin_id": "local.s3_origin_id",
                    "viewer_protocol_policy": "allow-all"
                },
                "Blocks": [
                    {
                        "Attributes": {
                            "query_string": false
                        },
                        "Blocks": [
                            {
                                "Attributes": {
                                    "forward": "none"
                                },
                                "Blocks": [],
                                "Labels": [],
                                "Type": "cookies",
                                "line_range": {
                                    "endLine": 47,
                                    "startLine": 45
                                }
                            }
                        ],
                        "Labels": [],
                        "Type": "forwarded_values",
                        "line_range": {
                            "endLine": 48,
                            "startLine": 42
                        }
                    }
                ],
                "Labels": [],
                "Type": "default_cache_behavior",
                "line_range": {
                    "endLine": 54,
                    "startLine": 37
                }
            },
            {
                "Attributes": {
                    "allowed_methods": [
                        "GET",
                        "HEAD",
                        "OPTIONS"
                    ],
                    "cached_methods": [
                        "GET",
                        "HEAD",
                        "OPTIONS"
                    ],
                    "compress": true,
                    "default_ttl": "86400",
                    "max_ttl": "3.1536e+07",
                    "min_ttl": "0",
                    "path_pattern": "/content/immutable/*",
                    "target_origin_id": "local.s3_origin_id",
                    "viewer_protocol_policy": "redirect-to-https"
                },
                "Blocks": [
                    {
                        "Attributes": {
                            "headers": [
                                "Origin"
                            ],
                            "query_string": false
                        },
                        "Blocks": [
                            {
                                "Attributes": {
                                    "forward": "none"
                                },
                                "Blocks": [],
                                "Labels": [],
                                "Type": "cookies",
                                "line_range": {
                                    "endLine": 69,
                                    "startLine": 67
                                }
                            }
                        ],
                        "Labels": [],
                        "Type": "forwarded_values",
                        "line_range": {
                            "endLine": 70,
                            "startLine": 63
                        }
                    }
                ],
                "Labels": [],
                "Type": "ordered_cache_behavior",
                "line_range": {
                    "endLine": 77,
                    "startLine": 57
                }
            },
            {
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
                    "compress": true,
                    "default_ttl": "3600",
                    "max_ttl": "86400",
                    "min_ttl": "0",
                    "path_pattern": "/content/*",
                    "target_origin_id": "local.s3_origin_id",
                    "viewer_protocol_policy": "redirect-to-https"
                },
                "Blocks": [
                    {
                        "Attributes": {
                            "query_string": false
                        },
                        "Blocks": [
                            {
                                "Attributes": {
                                    "forward": "none"
                                },
                                "Blocks": [],
                                "Labels": [],
                                "Type": "cookies",
                                "line_range": {
                                    "endLine": 91,
                                    "startLine": 89
                                }
                            }
                        ],
                        "Labels": [],
                        "Type": "forwarded_values",
                        "line_range": {
                            "endLine": 92,
                            "startLine": 86
                        }
                    }
                ],
                "Labels": [],
                "Type": "ordered_cache_behavior",
                "line_range": {
                    "endLine": 99,
                    "startLine": 80
                }
            },
            {
                "Attributes": {},
                "Blocks": [
                    {
                        "Attributes": {
                            "locations": [
                                "US",
                                "CA",
                                "GB",
                                "DE"
                            ],
                            "restriction_type": "whitelist"
                        },
                        "Blocks": [],
                        "Labels": [],
                        "Type": "geo_restriction",
                        "line_range": {
                            "endLine": 107,
                            "startLine": 104
                        }
                    }
                ],
                "Labels": [],
                "Type": "restrictions",
                "line_range": {
                    "endLine": 108,
                    "startLine": 103
                }
            },
            {
                "Attributes": {
                    "cloudfront_default_certificate": true
                },
                "Blocks": [],
                "Labels": [],
                "Type": "viewer_certificate",
                "line_range": {
                    "endLine": 116,
                    "startLine": 114
                }
            }
        ],
        "Labels": [
            "aws_cloudfront_distribution",
            "pass_1"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 118,
            "startLine": 9
        }
    }
]
	count(result) == 1
}

test_aws_cloudfront_s3_origin_config_with_oai_failed if {
	result := failed with input as [
    {
        "Attributes": {
            "bucket": "mybucket",
            "tags": {
                "Name": "My bucket"
            }
        },
        "Blocks": [],
        "Labels": [
            "aws_s3_bucket",
            "b"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "aliases": [
                "mysite.example.com",
                "yoursite.example.com"
            ],
            "comment": "Some comment",
            "default_root_object": "index.html",
            "enabled": true,
            "is_ipv6_enabled": true,
            "price_class": "PriceClass_200",
            "tags": {
                "Environment": "production"
            },
            "web_acl_id": "aws_wafv2_web_acl.example.arn"
        },
        "Blocks": [
            {
                "Attributes": {
                    "domain_name": "aws_s3_bucket.b.bucket_regional_domain_name",
                    "origin_id": "failoverS3"
                },
                "Blocks": [
                    {
                        "Attributes": {
                            "origin_access_identity": ""
                        },
                        "Blocks": [],
                        "Labels": [],
                        "Type": "",
                        "line_range": {
                            "endLine": 17,
                            "startLine": 15
                        }
                    }
                ],
                "Labels": [],
                "Type": "origin",
                "line_range": {
                    "endLine": 19,
                    "startLine": 12
                }
            },
            {
                "Attributes": {
                    "bucket": "mylogs.s3.amazonaws.com",
                    "include_cookies": false,
                    "prefix": "myprefix"
                },
                "Blocks": [],
                "Labels": [],
                "Type": "logging_config",
                "line_range": {
                    "endLine": 33,
                    "startLine": 29
                }
            },
            {
                "Attributes": {
                    "allowed_methods": [
                        "DELETE",
                        "GET",
                        "HEAD",
                        "OPTIONS",
                        "PATCH",
                        "POST",
                        "PUT"
                    ],
                    "cached_methods": [
                        "GET",
                        "HEAD"
                    ],
                    "default_ttl": "3600",
                    "max_ttl": "86400",
                    "min_ttl": "0",
                    "target_origin_id": "local.s3_origin_id",
                    "viewer_protocol_policy": "allow-all"
                },
                "Blocks": [
                    {
                        "Attributes": {
                            "query_string": false
                        },
                        "Blocks": [
                            {
                                "Attributes": {
                                    "forward": "none"
                                },
                                "Blocks": [],
                                "Labels": [],
                                "Type": "cookies",
                                "line_range": {
                                    "endLine": 47,
                                    "startLine": 45
                                }
                            }
                        ],
                        "Labels": [],
                        "Type": "forwarded_values",
                        "line_range": {
                            "endLine": 48,
                            "startLine": 42
                        }
                    }
                ],
                "Labels": [],
                "Type": "default_cache_behavior",
                "line_range": {
                    "endLine": 54,
                    "startLine": 37
                }
            },
            {
                "Attributes": {
                    "allowed_methods": [
                        "GET",
                        "HEAD",
                        "OPTIONS"
                    ],
                    "cached_methods": [
                        "GET",
                        "HEAD",
                        "OPTIONS"
                    ],
                    "compress": true,
                    "default_ttl": "86400",
                    "max_ttl": "3.1536e+07",
                    "min_ttl": "0",
                    "path_pattern": "/content/immutable/*",
                    "target_origin_id": "local.s3_origin_id",
                    "viewer_protocol_policy": "redirect-to-https"
                },
                "Blocks": [
                    {
                        "Attributes": {
                            "headers": [
                                "Origin"
                            ],
                            "query_string": false
                        },
                        "Blocks": [
                            {
                                "Attributes": {
                                    "forward": "none"
                                },
                                "Blocks": [],
                                "Labels": [],
                                "Type": "cookies",
                                "line_range": {
                                    "endLine": 69,
                                    "startLine": 67
                                }
                            }
                        ],
                        "Labels": [],
                        "Type": "forwarded_values",
                        "line_range": {
                            "endLine": 70,
                            "startLine": 63
                        }
                    }
                ],
                "Labels": [],
                "Type": "ordered_cache_behavior",
                "line_range": {
                    "endLine": 77,
                    "startLine": 57
                }
            },
            {
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
                    "compress": true,
                    "default_ttl": "3600",
                    "max_ttl": "86400",
                    "min_ttl": "0",
                    "path_pattern": "/content/*",
                    "target_origin_id": "local.s3_origin_id",
                    "viewer_protocol_policy": "redirect-to-https"
                },
                "Blocks": [
                    {
                        "Attributes": {
                            "query_string": false
                        },
                        "Blocks": [
                            {
                                "Attributes": {
                                    "forward": "none"
                                },
                                "Blocks": [],
                                "Labels": [],
                                "Type": "cookies",
                                "line_range": {
                                    "endLine": 91,
                                    "startLine": 89
                                }
                            }
                        ],
                        "Labels": [],
                        "Type": "forwarded_values",
                        "line_range": {
                            "endLine": 92,
                            "startLine": 86
                        }
                    }
                ],
                "Labels": [],
                "Type": "ordered_cache_behavior",
                "line_range": {
                    "endLine": 99,
                    "startLine": 80
                }
            },
            {
                "Attributes": {},
                "Blocks": [
                    {
                        "Attributes": {
                            "locations": [
                                "US",
                                "CA",
                                "GB",
                                "DE"
                            ],
                            "restriction_type": "whitelist"
                        },
                        "Blocks": [],
                        "Labels": [],
                        "Type": "geo_restriction",
                        "line_range": {
                            "endLine": 107,
                            "startLine": 104
                        }
                    }
                ],
                "Labels": [],
                "Type": "restrictions",
                "line_range": {
                    "endLine": 108,
                    "startLine": 103
                }
            },
            {
                "Attributes": {
                    "cloudfront_default_certificate": true
                },
                "Blocks": [],
                "Labels": [],
                "Type": "viewer_certificate",
                "line_range": {
                    "endLine": 116,
                    "startLine": 114
                }
            }
        ],
        "Labels": [
            "aws_cloudfront_distribution",
            "pass_1"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 118,
            "startLine": 9
        }
    }
]
	count(result) == 1
}
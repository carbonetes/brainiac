package lib.terraform.CB_TFAWS_327

import rego.v1 

test_s3_not_allow_access_to_all_authenticated_users_passed if {
	result := passed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-east-1"
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
            "aws_s3_bucket_acl",
            "fail_1"
        ],
        "Attributes": {
            "bucket": "name"
        },
        "Blocks": [
            {
                "Type": "access_control_policy",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "grant",
                        "Labels": [],
                        "Attributes": {
                            "permission": "READ"
                        },
                        "Blocks": [
                            {
                                "Type": "grantee",
                                "Labels": [],
                                "Attributes": {
                                    "id": "52b113e7a2f25102679df27bb0ae12b3f85be6",
                                    "type": "CanonicalUser"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 12,
                                    "startLine": 9
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 14,
                            "startLine": 8
                        }
                    },
                    {
                        "Type": "grant",
                        "Labels": [],
                        "Attributes": {
                            "permission": "READ_ACP"
                        },
                        "Blocks": [
                            {
                                "Type": "grantee",
                                "Labels": [],
                                "Attributes": {
                                    "type": "Group",
                                    "uri": "aaaaa"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 19,
                                    "startLine": 16
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 21,
                            "startLine": 15
                        }
                    },
                    {
                        "Type": "owner",
                        "Labels": [],
                        "Attributes": {
                            "id": "data.aws_canonical_user_id.current.id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 24,
                            "startLine": 22
                        }
                    }
                ],
                "line_range": {
                    "endLine": 25,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 26,
            "startLine": 5
        }
    }
]
	count(result) == 1
}

test_s3_not_allow_access_to_all_authenticated_users_failed if {
	result := failed with input as [
    {
        "Type": "provider",
        "Labels": [
            "aws"
        ],
        "Attributes": {
            "region": "us-east-1"
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
            "aws_s3_bucket_acl",
            "fail_1"
        ],
        "Attributes": {
            "bucket": "name"
        },
        "Blocks": [
            {
                "Type": "access_control_policy",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "grant",
                        "Labels": [],
                        "Attributes": {
                            "permission": "READ"
                        },
                        "Blocks": [
                            {
                                "Type": "grantee",
                                "Labels": [],
                                "Attributes": {
                                    "id": "52b113e7a2f25102679df27bb0ae12b3f85be6",
                                    "type": "CanonicalUser"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 12,
                                    "startLine": 9
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 14,
                            "startLine": 8
                        }
                    },
                    {
                        "Type": "grant",
                        "Labels": [],
                        "Attributes": {
                            "permission": "READ_ACP"
                        },
                        "Blocks": [
                            {
                                "Type": "grantee",
                                "Labels": [],
                                "Attributes": {
                                    "type": "Group",
                                    "uri": "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 19,
                                    "startLine": 16
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 21,
                            "startLine": 15
                        }
                    },
                    {
                        "Type": "owner",
                        "Labels": [],
                        "Attributes": {
                            "id": "data.aws_canonical_user_id.current.id"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 24,
                            "startLine": 22
                        }
                    }
                ],
                "line_range": {
                    "endLine": 25,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 26,
            "startLine": 5
        }
    }
]
	count(result) == 1
}
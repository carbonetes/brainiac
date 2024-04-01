package lib.terraform.CB_TFAWS_305

import rego.v1 

test_efs_access_user_identity_passed if {
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
            "aws_efs_file_system",
            "example"
        ],
        "Attributes": {
            "creation_token": "example",
            "encrypted": true,
            "performance_mode": "generalPurpose",
            "throughput_mode": "bursting"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_efs_access_point",
            "example"
        ],
        "Attributes": {
            "file_system_id": "aws_efs_file_system.example.id"
        },
        "Blocks": [
            {
                "Type": "posix_user",
                "Labels": [],
                "Attributes": {
                    "gid": "1000",
                    "uid": "1000"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 14
                }
            },
            {
                "Type": "root_directory",
                "Labels": [],
                "Attributes": {
                    "path": "/"
                },
                "Blocks": [
                    {
                        "Type": "creation_info",
                        "Labels": [],
                        "Attributes": {
                            "owner_gid": "1000",
                            "owner_uid": "1000",
                            "permissions": "755"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 26,
                            "startLine": 22
                        }
                    }
                ],
                "line_range": {
                    "endLine": 27,
                    "startLine": 20
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 12
        }
    }
]
	count(result) == 1
}

test_efs_access_user_identity_failed if {
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
            "aws_efs_file_system",
            "example"
        ],
        "Attributes": {
            "creation_token": "example",
            "encrypted": true,
            "performance_mode": "generalPurpose",
            "throughput_mode": "bursting"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_efs_access_point",
            "example"
        ],
        "Attributes": {
            "file_system_id": "aws_efs_file_system.example.id"
        },
        "Blocks": [
            {
                "Type": "posix_user",
                "Labels": [],
                "Attributes": {
                    "gid": "",
                    "uid": "1000"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 17,
                    "startLine": 14
                }
            },
            {
                "Type": "root_directory",
                "Labels": [],
                "Attributes": {
                    "path": "/"
                },
                "Blocks": [
                    {
                        "Type": "creation_info",
                        "Labels": [],
                        "Attributes": {
                            "owner_gid": "1000",
                            "owner_uid": "1000",
                            "permissions": "755"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 26,
                            "startLine": 22
                        }
                    }
                ],
                "line_range": {
                    "endLine": 27,
                    "startLine": 20
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 12
        }
    }
]
	count(result) == 1
}

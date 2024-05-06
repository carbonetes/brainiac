package lib.terraform.CB_TFAWS_303

import rego.v1 

test_efs_access_point_root_passed if {
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
            "aws_efs_file_system",
            "example"
        ],
        "Attributes": {
            "creation_token": "example-efs"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
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
            "access_point_id": "example-access-point",
            "file_system_id": "aws_efs_file_system.example.id"
        },
        "Blocks": [
            {
                "Type": "root_directory",
                "Labels": [],
                "Attributes": {
                    "path": "/efs"
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
                            "endLine": 19,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 20,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 33,
            "startLine": 9
        }
    }
]
	count(result) == 1
}

test_efs_access_point_root_failed if {
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
            "aws_efs_file_system",
            "example"
        ],
        "Attributes": {
            "creation_token": "example-efs"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
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
            "access_point_id": "example-access-point",
            "file_system_id": "aws_efs_file_system.example.id"
        },
        "Blocks": [
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
                            "endLine": 19,
                            "startLine": 15
                        }
                    }
                ],
                "line_range": {
                    "endLine": 20,
                    "startLine": 13
                }
            }
        ],
        "line_range": {
            "endLine": 33,
            "startLine": 9
        }
    }
]
	count(result) == 1
}

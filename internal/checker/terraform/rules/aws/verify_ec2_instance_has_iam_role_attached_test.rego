package lib.terraform.CB_TFAWS_321

import rego.v1 

test_ec2_instance_has_iam_role_attached if {
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
            "aws_instance",
            "example_instance"
        ],
        "Attributes": {
            "ami": "ami-0123456789abcdef0",
            "iam_instance_profile": "example-iam-role",
            "instance_type": "t2.micro",
            "tags": {
                "Name": "example-instance"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_iam_role",
            "example_role"
        ],
        "Attributes": {
            "name": "example-iam-role"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 31,
            "startLine": 16
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_iam_policy_attachment",
            "example_attachment"
        ],
        "Attributes": {
            "name": "example-attachment",
            "policy_arn": "aws_iam_role_policy.example_policy.arn",
            "roles": "aws_iam_role.example_role.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 37,
            "startLine": 33
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_iam_role_policy",
            "example_policy"
        ],
        "Attributes": {
            "name": "example-policy",
            "role": "aws_iam_role.example_role.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 53,
            "startLine": 39
        }
    }
]
	count(result) == 1
}

test_ec2_instance_has_no_iam_role_attached if {
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
            "aws_instance",
            "example_instance"
        ],
        "Attributes": {
            "ami": "ami-0123456789abcdef0",
            "instance_type": "t2.micro",
            "tags": {
                "Name": "example-instance"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 5
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_iam_role",
            "example_role"
        ],
        "Attributes": {
            "name": "example-iam-role"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 31,
            "startLine": 16
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_iam_policy_attachment",
            "example_attachment"
        ],
        "Attributes": {
            "name": "example-attachment",
            "policy_arn": "aws_iam_role_policy.example_policy.arn",
            "roles": "aws_iam_role.example_role.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 37,
            "startLine": 33
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "aws_iam_role_policy",
            "example_policy"
        ],
        "Attributes": {
            "name": "example-policy",
            "role": "aws_iam_role.example_role.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 53,
            "startLine": 39
        }
    }
]
	count(result) == 1
}